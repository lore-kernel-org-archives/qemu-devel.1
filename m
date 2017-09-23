Received: from eggs.gnu.org ([2001:4830:134:3::10]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tomoki.sekiyama@gmail.com>) id 1dvcxH-00065u-LZ
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:26:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tomoki.sekiyama@gmail.com>) id 1dvcxG-0001M2-0r
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:26:19 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:48881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tomoki.sekiyama@gmail.com>)
	id 1dvcxF-0001Lv-Pi
	for qemu-devel@nongnu.org; Sat, 23 Sep 2017 01:26:17 -0400
Received: by mail-oi0-x22b.google.com with SMTP id v188so1094162oia.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 22:26:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2876b52e.1e20.15eacb7b1a3.Coremail.chen_han_xiao@126.com>
References: <1506048366-23368-1-git-send-email-chen_han_xiao@126.com>
	<CAM1upfMHMYvkQNfqPFZqsz2rGC+X7UZECXAffMZ6Lnz4_Tn1AQ@mail.gmail.com>
	<2876b52e.1e20.15eacb7b1a3.Coremail.chen_han_xiao@126.com>
From: Tomoki Sekiyama <tomoki.sekiyama@gmail.com>
Date: Sat, 23 Sep 2017 14:26:16 +0900
Message-ID: <CAM1upfMr7dMLM3M1_xiPgxLr1RcjNgOrySxka=nEDKSgXG6C3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga-win: don't hang if vss hold writes
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Hanxiao <chen_han_xiao@126.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org

2017-09-23 12:11 GMT+09:00 Chen Hanxiao <chen_han_xiao@126.com>:

>
> =E5=9C=A8 2017-09-23 05:12:20=EF=BC=8C"Tomoki Sekiyama" <tomoki.sekiyama@=
gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>
> >
> > Thanks for your patch.
> > Which version of Windows have you found the hang?
> >
> >
>   I tested on win08, win 08 r2 and win2012.
>

Thank you for the info.

The patch looks good to me.

Regards,
Tomoki


> QGA versions:
>
>   Use the latest qga-win from
>   https://fedorapeople.org/groups/virt/virtio-win/direct-
> downloads/archive-qemu-ga/qemu-ga-win-7.4.5-1/
>
>   and stable branch from
>   https://fedorapeople.org/groups/virt/virtio-win/direct-
> downloads/archive-virtio/virtio-win-0.1.126-2/virtio-win-0.1.126.iso
>
>   All of them have the same behavior.
>
> How to reproduce:
>
>   Copy a big file in guest (from d: to c:), then do fsfreeze when IO is i=
n
> progress.
>
>   At this time, we had a very chance to see that qga hang for a long time=
.
>
>   Libvirt will not recieve a reply.
>   qemu-ga service even don't answer `net stop` command.
>
>
> Regards,
> - Chen
>
>
>
> > Regards,
> > Tomoki
> >
> >
> > 2017-09-22 11:46 GMT+09:00 Chen Hanxiao <chen_han_xiao@126.com>:
> >
> > From: Chen Hanxiao <chenhanxiao@gmail.com>
> >
> >
> >
> > When VM is in a heavy IO, if the command "guest-fsfreeze-freeze"
> >
> > is executed, VSS may timeout when trying to hold writes.
> >
> >
> >
> > Inside guest, Event ID 12298(VSS_ERROR_HOLD_WRITES_TIMEOUT)
> >
> > is logged in the Event Viewer.
> >
> >
> >
> > At that time, if we call AbortBackup, qga may hang forever.
> >
> >
> >
> > This patch will solve this issues.
> >
> >
> >
> > Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
> >
> > ---
> >
> >  qga/vss-win32/requester.cpp | 12 ++++++++++++
> >
> >  1 file changed, 12 insertions(+)
> >
> >
> >
> > diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> >
> > index 301762d..3d9c971 100644
> >
> > --- a/qga/vss-win32/requester.cpp
> >
> > +++ b/qga/vss-win32/requester.cpp
> >
> > @@ -419,6 +419,16 @@ void requester_freeze(int *num_vols, ErrorSet
> *errset)
> >
> >              break;
> >
> >          }
> >
> >      }
> >
> > +
> >
> > +    if (wait_status =3D=3D WAIT_TIMEOUT) {
> >
> > +        err_set(errset, E_FAIL,
> >
> > +                "timeout when try to receive Frozen event from VSS
> provider");
> >
> > +        /* If we are here, VSS had timeout.
> >
> > +         * Don't call AbortBackup, just return directly.
> >
> > +         */
> >
> > +        goto out1;
> >
> > +    }
> >
> > +
> >
> >      if (wait_status !=3D WAIT_OBJECT_0) {
> >
> >          err_set(errset, E_FAIL,
> >
> >                  "couldn't receive Frozen event from VSS provider");
> >
> > @@ -432,6 +442,8 @@ out:
> >
> >      if (vss_ctx.pVssbc) {
> >
> >          vss_ctx.pVssbc->AbortBackup();
> >
> >      }
> >
> > +
> >
> > +out1:
> >
> >      requester_cleanup();
> >
> >      CoUninitialize();
> >
> >  }
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
