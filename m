Received: from eggs.gnu.org ([2001:4830:134:3::10]:34722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVi3r-0000dS-4b
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dVi3q-0007gU-6m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 13:37:59 -0400
References: <20170713010555.6769-1-eblake@redhat.com>
	<20170713010555.6769-6-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <44b62783-48e6-2182-23e6-059b8b7d5e3c@redhat.com>
Date: Thu, 13 Jul 2017 13:37:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170713010555.6769-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/18] dirty-bitmap: Change
 bdrv_dirty_bitmap_size() to report bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/12/2017 09:05 PM, Eric Blake wrote:
> We are still using an internal hbitmap that tracks a size in sectors,
> with the granularity scaled down accordingly, because it lets us
> use a shortcut for our iterators which are currently sector-based.
> But there's no reason we can't track the dirty bitmap size in bytes,
> since it is (mostly) an internal-only variable (remember, the size
> is how many bytes are covered by the bitmap, not how many bytes the
> bitmap occupies).  Furthermore, we're already reporting bytes for
> bdrv_dirty_bitmap_granularity(); mixing bytes and sectors in our
> return values is a recipe for confusion.  A later cleanup will
> convert dirty bitmap internals to be entirely byte-based,
> eliminating the intermediate sector rounding added here; and
> technically, since bdrv_getlength() already rounds up to sectors,
> our use of DIV_ROUND_UP is more for theoretical completeness than
> for any actual rounding.
> 
> The only external caller in qcow2-bitmap.c is temporarily more verbose
> (because it is still using sector-based math), but will later be
> switched to track progress by bytes instead of sectors.
> 
> Use is_power_of_2() while at it, instead of open-coding that, and
> add an assertion where bdrv_getlength() should not fail.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 

Reviewed-by: John Snow <jsnow@redhat.com>
