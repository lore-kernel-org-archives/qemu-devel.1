Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6vvv-0003n4-EH
	for qemu-devel@nongnu.org; Sat, 06 May 2017 05:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6vvs-0005Sh-AU
	for qemu-devel@nongnu.org; Sat, 06 May 2017 05:23:23 -0400
Received: from hera.aquilenet.fr ([141.255.128.1]:42409)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d6vvs-0005Rq-3Y
	for qemu-devel@nongnu.org; Sat, 06 May 2017 05:23:20 -0400
Date: Sat, 6 May 2017 11:23:16 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170506092316.im32h7vth5rmvqtg@var.youpi.perso.aquilenet.fr>
References: <20170430075033.yjqj4ibssa52h4d7@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247905FC4B3FEE03780CF1EE9C150@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170430125703.pcp4ldw7oardptmn@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB247996FB5818A956470FE8169CEB0@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170505231433.ggp34jmzx4fad6jp@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479934DD8D5807C7A9DB0A39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506005600.6utgnirnrlm2g56i@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479B8C2F3EA375823AD6B6E9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
	<20170506011720.x7proxrmpvakd4it@var.youpi.perso.aquilenet.fr>
	<VI1PR0601MB2479B2228D4C769486ECAEC39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0601MB2479B2228D4C769486ECAEC39CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Subject: Re: [Qemu-devel] dns server not working in QEMU using usermode
 networking (SLIRP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

FONNEMANN Mark, on sam. 06 mai 2017 04:18:52 +0000, wrote:
> >That's so weird there's no packet log. Does your guest perhaps have the strace tool? Or perhaps you >can manage to copy it over from another VM, since it only depends on libc.
> 
> See attached file.

Ok, so for some reason it doesn't even try to emit a packet...

> open("/etc/resolv.conf", O_RDONLY)      = 3
> read(3, "nameserver 10.0.2.3\n\n", 4096) = 21

It does get the proper nameserver.

> connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)

It tries to connect to nscd but that's not running.

> open("/etc/nsswitch.conf", O_RDONLY)    = 3
> read(3, "hosts:      files\n", 4096)    = 18
> read(3, "", 4096)                       = 0

And I guess that's the culprit: in nsswitch.conf you only have
"hosts: files", so

> open("/lib/libnss_files.so.2", O_RDONLY) = 3
> open("/etc/hosts", O_RDONLY)            = 3
> read(3, "127.0.0.1\tlocalhost\n10.0.2.15\tqe"..., 4096) = 35

It only uses /etc/hosts.


So, in your /etc/nsswitch.conf, use

hosts: files dns

Samuel
