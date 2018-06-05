Received: from eggs.gnu.org ([2001:4830:134:3::10]:33380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQDeS-0007c0-91
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQDeP-0002C4-4b
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:13:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fQDeO-0002Bd-W3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:13:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55C5F805A530
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 15:13:32 +0000 (UTC)
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
	<1528207243-268226-3-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3bbeaa4-de51-11bc-ddf8-d83b809efc45@redhat.com>
Date: Tue, 5 Jun 2018 10:13:30 -0500
MIME-Version: 1.0
In-Reply-To: <1528207243-268226-3-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ldoktor@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, mreitz@redhat.com

On 06/05/2018 09:00 AM, Igor Mammedov wrote:
> When using --daemonize, the initial lead process will fork a child and
> then wait to be notified that setup is complete via a pipe, before it
> exits.  When using --preconfig there is an extra call to main_loop()
> before the notification is done from os_setup_post(). Thus the parent
> process won't exit until the mgmt application connects to the monitor
> and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
> won't connect to the monitor until daemonizing has completed though.
>=20
> This is a chicken and egg problem, leading to deadlock at startup.
>=20
> The only viable way to fix this is to call os_setup_post() before
> the early main_loop_wait() call when in RUN_STATE_PRECONFIG. This has
> the downside that any errors from this point onwards won't be handled
> well by the mgmt application, because it will think QEMU has started
> successfully, so not be expecting an abrupt exit. The only way to
> deal with that is to move as much user input validation as possible
> to before the main_loop() call. This is left as an exercise for
> future interested developers.
>=20
> Based on:
>    From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>    Subject: [PATCH v2 2/2] vl: fix use of --daemonize with --preconfig
>    Message-Id: <20180604120345.12955-3-berrange@redhat.com>
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>    - rewrite to apply on top of 1/2
> ---
>   os-posix.c | 6 ++++++
>   vl.c       | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/os-posix.c b/os-posix.c
> index 9ce6f74..ee06a8d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -309,8 +309,14 @@ void os_daemonize(void)
>  =20
>   void os_setup_post(void)
>   {
> +    static bool os_setup_post_done =3D false;

The '=3D false' is not technically necessary; all static variables defaul=
t=20
to zero-initialization.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
