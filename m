Received: from eggs.gnu.org ([2001:4830:134:3::10]:51193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Dde-0000kz-87
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6Ddd-0006sI-DA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:05:34 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-17-pbonzini@redhat.com>
	<20170504080521.GC4725@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4fb130d-08e6-b180-18c0-eaabe2fb8cfb@redhat.com>
Date: Thu, 4 May 2017 12:05:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170504080521.GC4725@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/17] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 10:05, Fam Zheng wrote:
>>      /* Writing to the list requires the BQL _and_ the dirty_bitmap_mu=
tex.
>>       * Reading from the list can be done with either the BQL or the
>> -     * dirty_bitmap_mutex.  Modifying a bitmap requires the AioContex=
t
>> -     * lock.  */
>> +     * dirty_bitmap_mutex.  Modifying a bitmap only requires
>> +     * dirty_bitmap_mutex.  */
> I'm confused by this comment. What's added in this patch is bitmap->mut=
ex, not
> dirty_bitmap_mutex. Is it a mistake?

bitmap->mutex is a pointer that points to the (single) per-BDS mutex.

This patch changes the modification of bitmaps to require bitmap->mutex
(which points to bs->dirty_bitmap_mutex) instead of the AioContext lock.

Paolo

>>      QemuMutex dirty_bitmap_mutex;
