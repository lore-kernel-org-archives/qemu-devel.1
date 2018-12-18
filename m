Received: from eggs.gnu.org ([2001:4830:134:3::10]:57980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZGwj-0007dC-EG
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZGwg-00012I-TZ
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:06:09 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Message-ID: <5139703f-0573-7498-b3a5-3d09661618ff@ilande.co.uk>
Date: Tue, 18 Dec 2018 15:05:50 +0000
MIME-Version: 1.0
In-Reply-To: <2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 18/12/2018 09:49, Mark Cave-Ayland wrote:

> Following on from this, the next patch "target/ppc: convert vsplt[bhw] to use vector
> operations" causes corruption of the OS X splash screen
> (https://www.ilande.co.uk/tmp/qemu/badapple2.png) in a way that suggests there may be
> an endian issue.

Changing "#ifndef HOST_WORDS_BIGENDIAN" to "#ifdef HOST_WORDS_BIGENDIAN" in this
patch helps a lot, but something still isn't quite right:
https://www.ilande.co.uk/tmp/qemu/badapple3.png.

Adding some more debugging seems to suggest that boffs is being handled correctly
based upon vece/uimm...

ins: vsplth  bofs before: 304e0
  bofs after: 304e0  uimm: 0  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e2  uimm: 1  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e4  uimm: 2  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e6  uimm: 3  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e0  uimm: 0  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e2  uimm: 1  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e4  uimm: 2  vece: 1
ins: vsplth  bofs before: 304e0
  bofs after: 304e6  uimm: 3  vece: 1
ins: vsplth  bofs before: 30560
  bofs after: 3056e  uimm: 7  vece: 1
ins: vsplth  bofs before: 30540
  bofs after: 3054e  uimm: 7  vece: 1
ins: vsplth  bofs before: 30490
  bofs after: 30492  uimm: 1  vece: 1
ins: vspltw  bofs before: 30580
  bofs after: 3058c  uimm: 3  vece: 2
ins: vsplth  bofs before: 30580
  bofs after: 30586  uimm: 3  vece: 1
ins: vspltw  bofs before: 30580
  bofs after: 30580  uimm: 0  vece: 2
ins: vspltb  bofs before: 30560
  bofs after: 30560  uimm: 0  vece: 0
ins: vsplth  bofs before: 304d0
  bofs after: 304d0  uimm: 0  vece: 1
ins: vsplth  bofs before: 304d0
  bofs after: 304d2  uimm: 1  vece: 1
ins: vsplth  bofs before: 304d0
  bofs after: 304d4  uimm: 2  vece: 1
ins: vsplth  bofs before: 304d0
  bofs after: 304d4  uimm: 2  vece: 1


ATB,

Mark.
