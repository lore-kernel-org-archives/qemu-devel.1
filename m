Received: from eggs.gnu.org ([2001:4830:134:3::10]:36943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3p5H-0008Mp-4R
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1e3p5C-0003l5-9W
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:00:27 -0400
Received: from mifritscher.de ([188.40.170.105]:59304
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1e3p5C-0003kY-1o
	for qemu-devel@nongnu.org; Sun, 15 Oct 2017 16:00:22 -0400
References: <20170929111323.6308-1-michael@fritscher.net>
	<c6489dce-108d-e163-589d-11e6f2c227da@redhat.com>
	<c507f03f377b2496da5e08af037a14ee.squirrel@mifritscher.de>
	<497f0cbe-3441-ae6b-ad25-0ebc092318cc@redhat.com>
	<693169b0c0e3904c935db314432bf671.squirrel@mifritscher.de>
	<f43e0c376d23066ee08736c43f99100d.squirrel@mifritscher.de>
	<20171015215055.19dbecc1@bahia.lan>
From: Michael Fritscher <michael@fritscher.net>
Message-ID: <a22a5c81-74c7-d2d3-eb47-9444f50bf6f1@fritscher.net>
Date: Sun, 15 Oct 2017 22:00:16 +0200
MIME-Version: 1.0
In-Reply-To: <20171015215055.19dbecc1@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: de-LU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, gkurz@linux.vnet.ibm.com

On 15.10.2017 21:50, Greg Kurz wrote:

>> Hi again,
>>
>> I see one thing: symlinks somewhere in the path (which seemed to be the
>> reason introducing the *at family). But I think that this can be handled
>> by canonlizing the path, too. realpath should do the job quite well.
>>
> 
> Unfortunately now because we have TOCTOU condition here: some path element
> could be replaced by a symlink after realpath() but before we actually pass
> the resulting path to a syscall.

Ah, yes, you are right. So lets go on the "hard way" (ntdll) again.

This approach seems to work in general, but somehow I get stack
corrumption or something like that after returning from a function which
makes the relativ NTOpenFile call. But should be fixable. Then the big
work piece is to emulate posix behavior with NT* functions *g*

Michael Fritscher
