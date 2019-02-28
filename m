Received: from eggs.gnu.org ([209.51.188.92]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzOlM-0007by-Qx
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzOlM-0008IL-1g
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:42:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzOlL-00086f-FB
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:42:23 -0500
References: <38A2C2D0FB356A4785EEFA56D99BFB2B0B718883@SHSMSX101.ccr.corp.intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <14b75ee9-7a5f-eb69-f210-f7b2e72cbaf8@redhat.com>
Date: Thu, 28 Feb 2019 17:41:59 +0100
MIME-Version: 1.0
In-Reply-To: <38A2C2D0FB356A4785EEFA56D99BFB2B0B718883@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu build failure with uninitialized variables
 when "-Wmaybe-uninitialized" is open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wei, Danmei" <danmei.wei@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Hao, Xudong" <xudong.hao@intel.com>

On 28/02/2019 04.00, Wei, Danmei wrote:
> Hi,
> 
> When we build qemu with "-Wmaybe-uninitialized" on, and got the following error information.
>   CC      qobject/json-streamer.o
>   CC      qobject/json-parser.o
>   CC      qobject/block-qdict.o
> qobject/block-qdict.c: In function 'qdict_array_split':
> qobject/block-qdict.c:259:25: error: 'subqdict' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>          qlist_append_obj(*dst, subqobj ?: QOBJECT(subqdict));
>                          ^
> cc1: all warnings being treated as errors
> make: *** [qobject/block-qdict.o] Error 1
> 
> It is because of the uninitialized variable subqdict function qdict_array_split.
> Thanks to confirm it.
> 
> Below is the ENV Setting:
> OS: RHEL OS 7.6
> Qemu Version: commit c102d9471f8f02d9fbea72ec4505d7089173f470
> CFLAGS Setting in env: export CFLAGS="-g -O3 -Wmaybe-uninitialized"

Don't build QEMU with -O3 and -Wmaybe-uninitialized and -Werror
together. -O3 produces lots of false warnings with
-Wmaybe-uninitialized, so we currently don't support building QEMU with
that combination. You should at least add
"-Wno-error=maybe-uninitialized" if you want to build that way.

 Thomas
