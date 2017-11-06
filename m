Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBjHl-0005dT-V9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBjHh-0007OD-W4
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:26:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBjHh-0007Nu-Pp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 10:25:57 -0500
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-16-michael@fritscher.net>
	<d86b8115-9512-d487-a508-906c5f259764@redhat.com>
	<5bc62a3a54dd9c1eb19c41bc5f710e3e.squirrel@mifritscher.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ddc5dee-3481-25c5-84b3-acbaf9d3d323@redhat.com>
Date: Mon, 6 Nov 2017 16:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <5bc62a3a54dd9c1eb19c41bc5f710e3e.squirrel@mifritscher.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/18] Fix unavailable fields in stbuf
 under Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 06/11/2017 16:23, Michael Fritscher wrote:
>> Likewise, I think it should be struct FileOperations's lstat member that
>> uses struct V9fsStatDotl instead of struct stat.  Then
>> stat_to_v9stat_dotl would be hidden inside 9p-local.c (and 9p-local.c
>> isn't going to be used by Windows at all, so this patch disappears).
>>
>> Paolo
>>
> At first: thanks for reviewing!
> 
> Yes, the main question for me at this stage is:
>   * use the 9p-local.c and try workaround the limitations (e.g. lack of
> the *at functions) by creating stubs)
>   * make a own 9p-local-windows.c and use ntdlls functions, which is a bit
> more ugly.
> 
> I decribed these options a moment ago in the other mail in more detail.
> For me both way are fine.

Given the limitations of the Windows standard C library, I think the
latter makes more sense.  It could be kernel32 or ntdll, that doesn't
really matter (though ntdll is a better match for 9p and I think it's
worth it); but msvcrt is probably just as ugly as ntdll and even more
limited than kernel32.

Paolo
