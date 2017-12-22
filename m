Received: from eggs.gnu.org ([2001:4830:134:3::10]:59164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNJj-0004qI-6n
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eSNJi-0001Us-7e
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:24:51 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eSNJi-0001Tj-0T
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:24:50 -0500
Received: by mail-wm0-x243.google.com with SMTP id b76so21757343wmg.1
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 05:24:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-10-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-10-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Dec 2017 14:24:48 +0100
Message-ID: <CAJ+F1CKOq2p_Nsz6EFQCHGhfj7ntD6z2aohWPadrKXtEJS8WAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/13] tpm: Introduce condition to
 notify waiters of completed command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Introduce a lock and a condition to notify anyone waiting for the complet=
ion
> of the execution of a TPM command by the backend (thread). The backend
> uses the condition to signal anyone waiting for command completion.
> We need to place the condition in two locations: one is invoked by the
> backend thread, the other by the bottom half thread.
> We will use the signaling to wait for command completion before VM
> suspend.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 035c6ef..86e9a92 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -80,6 +80,9 @@ typedef struct TPMState {
>      TPMVersion be_tpm_version;
>
>      size_t be_buffer_size;
> +
> +    QemuMutex state_lock;
> +    QemuCond cmd_complete;

Looks like the cond is unused in the following patches.

>  } TPMState;
>
>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -405,6 +408,8 @@ static void tpm_tis_request_completed(TPMIf *ti)
>          }
>      }
>
> +    qemu_mutex_lock(&s->state_lock);
> +

I get grumpy with multiple threads... Potentially, many threads will
want to use TPMState: main thread, backend thread (hopefully not with
the bh), migration thread (with the next patches...), and vcpu thread.
It's hard to review which part of TPMState needs mux and which
doesn't. Why do you lock only in this function? After checking
s->cmd.selftest_done & modifying s->loc[locty].sts...

>      tpm_tis_sts_set(&s->loc[locty],
>                      TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
>      s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
> @@ -419,6 +424,10 @@ static void tpm_tis_request_completed(TPMIf *ti)
>
>      tpm_tis_raise_irq(s, locty,
>                        TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID=
);
> +
> +    /* notify of completed command */
> +    qemu_cond_signal(&s->cmd_complete);
> +    qemu_mutex_unlock(&s->state_lock);
>  }
>
>  /*
> @@ -1046,6 +1055,9 @@ static void tpm_tis_initfn(Object *obj)
>      memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
>                            s, "tpm-tis-mmio",
>                            TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHI=
FT);
> +
> +    qemu_mutex_init(&s->state_lock);
> +    qemu_cond_init(&s->cmd_complete);
>  }
>
>  static void tpm_tis_class_init(ObjectClass *klass, void *data)
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
