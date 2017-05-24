Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1dDY26-00044w-So
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu.bugs@whitewinterwolf.com>) id 1dDY22-0004HA-Um
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:17:06 -0400
Received: from relay2-d.mail.gandi.net ([2001:4b98:c:538::194]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu.bugs@whitewinterwolf.com>)
	id 1dDY22-0004Fe-Nv
	for qemu-devel@nongnu.org; Wed, 24 May 2017 11:17:02 -0400
Received: from mfilter6-d.gandi.net (mfilter6-d.gandi.net [217.70.178.135])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id 698FDC5A6C
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 17:17:00 +0200 (CEST)
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter6-d.gandi.net (mfilter6-d.gandi.net [::ffff:10.0.15.180])
	(amavisd-new, port 10024)
	with ESMTP id SZvfYzsw70oo for <qemu-devel@nongnu.org>;
	Wed, 24 May 2017 17:16:59 +0200 (CEST)
Received: from webmail.eu.com (webmail5-d.mgt.gandi.net [10.58.1.145])
	(Authenticated sender: lists@whitewinterwolf.com)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPA id 1D01BC5A73
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 17:16:58 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 24 May 2017 17:16:58 +0200
From: Simon <qemu.bugs@whitewinterwolf.com>
Message-ID: <6ace537dec6122d5bd07e600b9ab9b6c@whitewinterwolf.com>
Subject: [Qemu-devel] Monitor file path length limitation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

It seems that the monitor file path length is limited to about 100 
characters (107 to be precise).

Currently I'm using the '-monitor' parameter to create the monitor file 
in a directory which gather all the files related to a given VM (monitor 
file, PID file, disk image, etc.):

-monitor 
'unix:/home/user/vmtools/test/out/foobar.iso/foobar.iso_A/foobar.iso_B/foobar.iso_C/foobar.iso_D/foobar.iso_E/monitor.sock,server,nowait'

With this command Qemu does not produce any warning or error message but 
create the socket file "mon" instead of the expected "monitor.sock".

Things go even worse if I add a further nesting:

-monitor 
'unix:/home/user/vmtools/test/out/foobar.iso/foobar.iso_A/foobar.iso_B/foobar.iso_C/foobar.iso_D/foobar.iso_E/foobar.iso_F/monitor.sock,server,nowait'

Now, still without any warning, Qemu creates a file named "foo" in the 
parent directory ('foobar.iso_E/') instead of the expected directory 
('foobar.iso_E/').

Is there a clean way to work around this limitation? For instance, is 
there an alternative option I can use to generate this monitor file? Or 
should I just assume that absolute paths are not supported in the 
'-monitor' option and change the working directory before launching Qemu 
so I can pass "./monitor.sock" as monitor file path (I really prefer to 
use absolute path whenever possible though).

As a side-note, is there any technical reason for such a limitation?

Regards,
Simon.
