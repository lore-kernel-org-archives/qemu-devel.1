Received: from eggs.gnu.org ([2001:4830:134:3::10]:57615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5Ea-0003Kv-8v
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dD5EX-0007ug-5b
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:32:04 -0400
Received: from mail-ve1eur01on0097.outbound.protection.outlook.com
	([104.47.1.97]:8758
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dD5EW-0007tk-Q0
	for qemu-devel@nongnu.org; Tue, 23 May 2017 04:32:01 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-4-git-send-email-anton.nefedov@virtuozzo.com>
	<fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <53413715-77ed-0b86-c893-df8575c302ce@virtuozzo.com>
Date: Tue, 23 May 2017 11:31:51 +0300
MIME-Version: 1.0
In-Reply-To: <fb751647-3473-76e2-bc49-bf2c9734a027@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/13] qcow2: do not COW the empty areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, "Denis V . Lunev" <den@openvz.org>, den@virtuozzo.com, mreitz@redhat.com



On 05/22/2017 10:24 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> If COW area of the newly allocated cluster is zeroes, there is no reason
>> to write zero sectors in perform_cow() again now as whole clusters are
>> zeroed out in single chunks by handle_alloc_space().
>
> But that's only true if you can guarantee that handle_alloc_space()
> succeeded at ensuring the cluster reads as zeroes.  If you silently
> ignore errors (which is what patch 1/13 does), you risk assuming that
> the cluster reads as zeroes when in reality it does not, and then you
> have corrupted data.
>

Sure; COW is only skipped if pwrite_zeroes() from patch 1/13
succeeds

> The idea of avoiding a COW of areas that read as zero at the source when
> the destination also already reads as zeroes makes sense, but I'm not
> convinced that this patch is safe as written.
>

/Anton
