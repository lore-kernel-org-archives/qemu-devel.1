Received: from eggs.gnu.org ([2001:4830:134:3::10]:48913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8TtR-0008FB-DZ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8TtN-0001y0-BI
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:51:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8TtN-0001xs-5S
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:51:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <149373610338.5144.9635049015143453288.stgit@bahia.lan>
Date: Wed, 10 May 2017 17:51:06 +0200
In-Reply-To: <149373610338.5144.9635049015143453288.stgit@bahia.lan> (Greg
	Kurz's message of "Tue, 02 May 2017 16:41:43 +0200")
Message-ID: <87mvaku2vp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] scripts/qmp/qom-set: fix the value
 argument passed to srv.command()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

Greg Kurz <groug@kaod.org> writes:

> When invoking the script with -s, we end up passing a bogus value
> to QEMU:
>
> $ ./scripts/qmp/qom-set -s /var/tmp/qmp-sock-exp /machine.accel kvm
> {}
> $ ./scripts/qmp/qom-get -s /var/tmp/qmp-sock-exp /machine.accel
> /var/tmp/qmp-sock-exp
>
> This happens because sys.argv[2] isn't necessarily the command line
> argument that holds the value. It is sys.argv[4] when -s was also
> passed.
>
> Actually, the code already has a variable to handle that. This patch
> simply uses it.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  scripts/qmp/qom-set |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
> index 54ecfecc531e..94e27789224c 100755
> --- a/scripts/qmp/qom-set
> +++ b/scripts/qmp/qom-set
> @@ -61,4 +61,4 @@ else:
>  srv = QEMUMonitorProtocol(socket_path)
>  srv.connect()
>  
> -print srv.command('qom-set', path=path, property=prop, value=sys.argv[2])
> +print srv.command('qom-set', path=path, property=prop, value=value)

Given Python modules like argparse, doing option parsing by hand is
basically stupid.  This patch fixes it without making it any stupider.
Sold.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
