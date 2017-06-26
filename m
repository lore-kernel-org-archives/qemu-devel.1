Received: from eggs.gnu.org ([2001:4830:134:3::10]:58457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPXHo-000189-IA
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dPXHl-0006f7-Gu
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:54:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dPXHl-0006dB-BU
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:54:49 -0400
References: <20170605123908.18777-1-pbonzini@redhat.com>
	<20170605123908.18777-17-pbonzini@redhat.com>
	<e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37960694-8f25-8201-5f17-e59c3ee67e90@redhat.com>
Date: Mon, 26 Jun 2017 18:54:41 +0200
MIME-Version: 1.0
In-Reply-To: <e138c191-5f28-ff50-1b86-d4d1a416eadc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] block: protect modification of dirty
 bitmaps with a mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com



On 26/06/2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> HI!
> 
> One question here, should not 'bdrv_undo_clear_dirty_bitmap' be under
> lock too?

Any call to dirty bitmap functions between bdrv_clear_dirty_bitmap and
bdrv_undo_clear_dirty_bitmap is problematic anyway, so
bdrv_clear_dirty_bitmap really only needs the lock in the !out case;
bdrv_undo_clear_dirty_bitmap is only called when out != NULL.

However, I agree it would be cleaner to add the lock there, too.

Paolo
