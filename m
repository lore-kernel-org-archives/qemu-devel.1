Received: from eggs.gnu.org ([2001:4830:134:3::10]:59239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cddh1-0000Da-S3
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cddh0-0008Vr-Lc
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:02:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cddh0-0008Vk-FS
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 09:02:54 -0500
Date: Tue, 14 Feb 2017 14:02:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170214140249.GJ2463@work-vm>
References: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] migration capability to discard the
 migrated ram pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

Hi Pavel,
  I was curious, having merged this, how you're using postcopy; do you switch
into postcopy mode immediately or wait until the first sync or what?
Do you find yourself in postcopy mode long enough that it's worth
doing the release?  If so on what size VMs are you working with?

Dave

* Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
> This feature frees the migrated memory on the source during postcopy-ram
> migration. In the second step of postcopy-ram migration when the source vm
> is put on pause we can free unnecessary memory. It will allow, in particular,
> to start relaxing the memory stress on the source host in a load-balancing
> scenario.
> 
> Changes from v1:
> - changed name of the interfaces (discard to release)
> - fix make check error
> - add more comments to qemu_iovec_release_ram()
> - rebase on "Postcopy: Hugepage support" (David's patch series)
> - removed ram_discard_page for xbzrle 
> - fix erroneous release memory in complete precopy (tie release-ram to postcopy)
> 
> Pavel Butsykin (3):
>   migration: add MigrationState arg for ram_save_/compressed_/page()
>   add 'release-ram' migrate capability
>   migration: discard non-dirty ram pages after the start of postcopy
> 
>  include/migration/migration.h |  2 ++
>  include/migration/qemu-file.h |  3 ++-
>  migration/migration.c         | 13 ++++++++++
>  migration/qemu-file.c         | 59 ++++++++++++++++++++++++++++++++++++++-----
>  migration/ram.c               | 56 ++++++++++++++++++++++++++++++++++------
>  qapi-schema.json              |  5 +++-
>  6 files changed, 121 insertions(+), 17 deletions(-)
> 
> -- 
> 2.11.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
