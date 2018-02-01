Received: from eggs.gnu.org ([2001:4830:134:3::10]:33236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehF0v-0001rV-9O
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ehF0u-0004En-Bp
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:53 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-4-git-send-email-anton.nefedov@virtuozzo.com>
	<ac354ca7-a569-42f4-1aab-0274b269b50b@redhat.com>
	<48b265f6-eebf-3c09-0b84-aaa9260c6d41@virtuozzo.com>
	<b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <16ae4c8c-4296-1583-8a65-055f1b2c02a9@virtuozzo.com>
Date: Thu, 1 Feb 2018 16:34:39 +0300
MIME-Version: 1.0
In-Reply-To: <b3fdc845-173f-7d92-c157-4e83eb920af6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 3/9] block: introduce BDRV_REQ_ALLOCATE
 flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com

On 31/1/2018 8:31 PM, Max Reitz wrote:
> On 2018-01-30 13:34, Anton Nefedov wrote:
>> Offtop: does REQ_ZERO_WRITE override REQ_WRITE_COMPRESSED in this
>> function? at least with !REQ_MAY_UNMAP it looks wrong
> 
> Looks like zero detection will indeed override compression.  I think
> that was intended, but I don't even have an opinion either way.
> 
> Of course, it wouldn't be so nice if you tried to compress something and
> then, because the zero write failed, you actually write uncompressed
> zeroes...  But since zero detection is an optional feature, it might be
> your own fault if you enable it when you want compression anyway, and if
> you write to some format/protocol combination that doesn't allow zero
> writes.
> 
> Max
> 

Is it detection only? I guess in case the caller sets
(REQ_ZERO_WRITE | REQ_COMPRESSED) it also fires here.

Looks like noone does that though, but for example backup might;
it supports compression, and it also does a zero detection itself and
calls write_zeroes() when it can.
It sets REQ_MAY_UNMAP which should indeed override a compression, but
unmap might be not supported.

/Anton
