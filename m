Received: from eggs.gnu.org ([2001:4830:134:3::10]:50597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fPqMq-0000nA-C0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fPqMp-0000gk-E4
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fPqMp-0000gc-9M
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E89294022414
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 14:21:50 +0000 (UTC)
References: <20180604120345.12955-1-berrange@redhat.com>
	<20180604120345.12955-3-berrange@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <fecc57bf-78a3-065c-729d-a465c974b2c5@redhat.com>
Date: Mon, 4 Jun 2018 16:21:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180604120345.12955-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

On 06/04/2018 02:03 PM, Daniel P. Berrang=C3=A9 wrote:
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
> the early main_loop() call when in RUN_STATE_PRECONFIG. This has the
> downside that any errors from this point onwards won't be handled
> well by the mgmt application, because it will think QEMU has started
> successfully, so not be expecting an abrupt exit. The only way to
> deal with that is to move as much user input validation as possible
> to before the main_loop() call. This is left as an exercise for
> future interested developers.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  vl.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Yup, this fixes the problem I've raised in my patch. Thanks!

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

(if my R-b line means anything here :-))

Michal
