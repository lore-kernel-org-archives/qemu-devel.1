Received: from eggs.gnu.org ([2001:4830:134:3::10]:53923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv3zB-0007U7-0p
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fv3z6-0001Rj-Qd
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 13:10:28 -0400
Date: Wed, 29 Aug 2018 14:10:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180829171021.GA17213@habkost.net>
References: <23DA939E-B500-4ABE-A484-1FE1CB43B48A@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23DA939E-B500-4ABE-A484-1FE1CB43B48A@me.com>
Subject: Re: [Qemu-devel] [PATCH] Add support for TCP path/QMP_PATH in
 scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Tue, Aug 28, 2018 at 09:32:18PM +0800, Chen Zhang wrote:
> From a1f93198020b8c043edab5292db39b52ac77f78b Mon Sep 17 00:00:00 2001
> 
> Signed-off-by: Zhang Chen <tgfbeta@me.com>
> ---
>  scripts/qmp/qmp | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
> index 6cb46fd..0e8ed19 100755
> --- a/scripts/qmp/qmp
> +++ b/scripts/qmp/qmp
> @@ -63,6 +63,16 @@ def main(args):
>      if not path:
>          print("QMP path isn't set, use --path=qmp-monitor-address or set QMP_PATH")
>          return 1
> +    tcp_addr = path.split(':')
> +    if len(tcp_addr) == 2:
> +        try:
> +            port = int(tcp_addr[1])
> +        except ValueError:
> +            print("QMP path contains a non-numeric TCP port")
> +            return 1
> +        addr = ( tcp_addr[0], port )
> +    else:
> +        addr = path

I don't think this qualifies as trivial patch.

I'm not against extending scripts/qmp/qmp this way, but this
deserves some coordination to allow usage of QMP addresses that
are not unix sockets in other scripts too.  Supporting libvirt's
qemu-monitor-command would be another use case for this.  See:

https://www.mail-archive.com/qemu-block@nongnu.org/msg41351.html

I suggest adding a new option name (e.g. --tcp) to explicitly
tell the script you have a hostname:port pair, for simplicity.
It doesn't make sense to overload an option named "path" for
something that is not a path.


>  
>      if len(args):
>          command, args = args[0], args[1:]
> @@ -74,7 +84,7 @@ def main(args):
>      if command in ['help']:
>          os.execlp('man', 'man', 'qmp')
>  
> -    srv = QEMUMonitorProtocol(path)
> +    srv = QEMUMonitorProtocol(addr)
>      srv.connect()
>  
>      def do_command(srv, cmd, **kwds):
> @@ -99,7 +109,7 @@ def main(args):
>              raise
>          return 0
>  
> -    srv = QEMUMonitorProtocol(path)
> +    srv = QEMUMonitorProtocol(addr)
>      srv.connect()
>  
>      arguments = {}
> -- 
> 2.7.4
> 

-- 
Eduardo
