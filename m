Received: from eggs.gnu.org ([2001:4830:134:3::10]:33675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1detft-0004u7-Du
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1detfo-0004um-OT
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 21:51:13 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-28-git-send-email-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6cd9bc96-cf63-e381-6094-030f4eb396e8@redhat.com>
Date: Mon, 7 Aug 2017 21:50:50 -0400
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-28-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 27/56] block/dirty-bitmap: Clean up
 signed vs. unsigned dirty counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, jcody@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com



On 08/07/2017 10:45 AM, Markus Armbruster wrote:
> hbitmap_count() returns uint64_t.
> 
> Clean up test-hbitmap.c to check its value with g_assert_cmpuint()
> instead of g_assert_cmpint().
> 
> bdrv_get_dirty_count() and bdrv_get_meta_dirty_count() return its
> value converted to int64_t.  Clean them up to return it unadulterated.
> 
> This moves the implicit conversion to some callers, so clean them up,
> too.
> 
> mirror_run() assigns the value of bdrv_get_meta_dirty_count() to a
> local int64_t variable.  Change it to uint64_t.  Signedness still gets
> mixed up in the computation of s->common.len, but messing with that is
> more than I can handle right now.
> 
> get_remaining_dirty() tallies bdrv_get_dirty_count() values in
> int64_t.  Its caller block_save_pending() converts it back to
> uint64_t.  Change get_remaining_dirty() to uint64_t.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

So these functions can't fail, so there's no reason to keep the int64_t
type around, OK.

Reviewed-by: John Snow <jsnow@redhat.com>
