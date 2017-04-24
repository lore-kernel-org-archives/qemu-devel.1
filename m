Received: from eggs.gnu.org ([2001:4830:134:3::10]:47158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2ZqH-00062a-Fc
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d2ZqC-0007Q8-Ks
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:59:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d2ZqC-0007Q0-BZ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 04:59:28 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3O8wpoQ039885
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 04:59:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a038qqk1b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 04:59:26 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 24 Apr 2017 09:59:23 +0100
Date: Mon, 24 Apr 2017 10:59:19 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
References: <1492626091-30531-1-git-send-email-tgnyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20170424105919.2bf6754f.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/char: remove console_exit function
 in sclp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <tgnyang@gmail.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 20 Apr 2017 02:21:29 +0800
Zihan Yang <tgnyang@gmail.com> wrote:

>     Currently, the console_exit function in sclpconsole-lm.c and
>     sclpconsole.c does nothing, just remove them. Since there is
>     a NULL check on the DeviceClass exit callback as suggested by
>     Frederic Konrad, it should be safe to simply remove them.

Something strange happened to the commit message (leading whitespace).

You should also mention that you convert the callback to void.

>=20
> Signed-off-by: Zihan Yang <tgnyang@gmail.com>
> ---
>  hw/char/sclpconsole-lm.c          | 6 ------
>  hw/char/sclpconsole.c             | 6 ------
>  include/hw/s390x/event-facility.h | 2 +-
>  3 files changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
> index 07d6ebd..86ddda6 100644
> --- a/hw/char/sclpconsole-lm.c
> +++ b/hw/char/sclpconsole-lm.c
> @@ -318,11 +318,6 @@ static int console_init(SCLPEvent *event)
>      return 0;
>  }
>=20
> -static int console_exit(SCLPEvent *event)
> -{
> -    return 0;
> -}
> -
>  static void console_reset(DeviceState *dev)
>  {
>     SCLPEvent *event =3D SCLP_EVENT(dev);
> @@ -349,7 +344,6 @@ static void console_class_init(ObjectClass *klass, vo=
id *data)
>      dc->reset =3D console_reset;
>      dc->vmsd =3D &vmstate_sclplmconsole;
>      ec->init =3D console_init;
> -    ec->exit =3D console_exit;
>      ec->get_send_mask =3D send_mask;
>      ec->get_receive_mask =3D receive_mask;
>      ec->can_handle_event =3D can_handle_event;
> diff --git a/hw/char/sclpconsole.c b/hw/char/sclpconsole.c
> index b78f240..e916cac 100644
> --- a/hw/char/sclpconsole.c
> +++ b/hw/char/sclpconsole.c
> @@ -246,11 +246,6 @@ static void console_reset(DeviceState *dev)
>     scon->notify =3D false;
>  }
>=20
> -static int console_exit(SCLPEvent *event)
> -{
> -    return 0;
> -}
> -
>  static Property console_properties[] =3D {
>      DEFINE_PROP_CHR("chardev", SCLPConsole, chr),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -265,7 +260,6 @@ static void console_class_init(ObjectClass *klass, vo=
id *data)
>      dc->reset =3D console_reset;
>      dc->vmsd =3D &vmstate_sclpconsole;
>      ec->init =3D console_init;
> -    ec->exit =3D console_exit;
>      ec->get_send_mask =3D send_mask;
>      ec->get_receive_mask =3D receive_mask;
>      ec->can_handle_event =3D can_handle_event;
> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
> index def1bb0..1a32f3a 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h
> @@ -162,7 +162,7 @@ typedef struct SCLPEvent {
>  typedef struct SCLPEventClass {
>      DeviceClass parent_class;
>      int (*init)(SCLPEvent *event);
> -    int (*exit)(SCLPEvent *event);
> +    void (*exit)(SCLPEvent *event);
>=20
>      /* get SCLP's send mask */
>      unsigned int (*get_send_mask)(void);

You missed one:

/home/cohuck/git/qemu/hw/s390x/event-facility.c: In function =E2=80=98event=
_unrealize=E2=80=99:
/home/cohuck/git/qemu/hw/s390x/event-facility.c:416:18: error: void value n=
ot ignored as it ought to be
