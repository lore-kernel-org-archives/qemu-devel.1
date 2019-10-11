Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB38ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C212084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 10:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C212084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIrxx-0000y5-Tv
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 06:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iIrxI-0000ZM-1H
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iIrxG-0004iT-NO
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46626)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iIrxG-0004i8-Ej
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 06:15:26 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EDD9317528A;
 Fri, 11 Oct 2019 10:15:25 +0000 (UTC)
Received: from work-vm (ovpn-117-210.ams2.redhat.com [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E5F53CC8;
 Fri, 11 Oct 2019 10:15:24 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:15:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/2] migration/postcopy: map large zero page in
 postcopy_ram_incoming_setup()
Message-ID: <20191011101522.GN3354@work-vm>
References: <20191005135021.21721-1-richardw.yang@linux.intel.com>
 <20191005135021.21721-3-richardw.yang@linux.intel.com>
 <20191008172423.GH3441@work-vm> <20191009011048.GD26203@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009011048.GD26203@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 11 Oct 2019 10:15:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Tue, Oct 08, 2019 at 06:24:23PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> postcopy_ram_incoming_setup() and postcopy_ram_incoming_cleanup() are
> >> counterpart. It is reasonable to map/unmap large zero page in these two
> >> functions respectively.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >
> >Yes, OK.
> >
> >> ---
> >>  migration/postcopy-ram.c | 34 +++++++++++++++++-----------------
> >>  1 file changed, 17 insertions(+), 17 deletions(-)
> >> 
> >> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> >> index e554f93eec..813cfa5c42 100644
> >> --- a/migration/postcopy-ram.c
> >> +++ b/migration/postcopy-ram.c
> >> @@ -1142,6 +1142,22 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
> >>          return -1;
> >>      }
> >>  
> >> +    /*
> >> +     * Map large zero page when kernel can't use UFFDIO_ZEROPAGE for hugepages
> >> +     */
> >> +    mis->postcopy_tmp_zero_page = mmap(NULL, mis->largest_page_size,
> >> +                                       PROT_READ | PROT_WRITE,
> >> +                                       MAP_PRIVATE | MAP_ANONYMOUS,
> >> +                                       -1, 0);
> >> +    if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
> >> +        int e = errno;
> >> +        mis->postcopy_tmp_zero_page = NULL;
> >> +        error_report("%s: Failed to map large zero page %s",
> >> +                     __func__, strerror(e));
> >> +        return -e;
> >
> >Note this starts returning -errno where the rest of this function
> >returns 0 or -1;  returning -errno is a good thing I think and it might
> >be good to change the other returns.
> >
> 
> This is reasonable, while I am thinking how caller would handle this.
> 
> For example, the return value would be finally returned to
> qemu_loadvm_state_main(). If we handle each errno respectively in this
> function, the code would be difficult to read and maintain.
> 
> Would it be good to classify return value to different category? Like
> 
>   POSTCOPY_FATAL
>   POSTCOPY_RETRY
>   POSTCOPY_DISABLE

It's actually quite difficult because unix errno's are too simple;
an EIO has too many causes.
ideally we'd like to be able to separate out a network transport error
that occurs during the postcopy phase for recovery and make sure
that we don't confuse that with any other error.  

Dave

> 
> >
> >Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >> +    }
> >> +    memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
> >> +
> >>      /*
> >>       * Ballooning can mark pages as absent while we're postcopying
> >>       * that would cause false userfaults.
> >> @@ -1248,23 +1264,7 @@ int postcopy_place_page_zero(MigrationIncomingState *mis, void *host,
> >>                                             qemu_ram_block_host_offset(rb,
> >>                                                                        host));
> >>      } else {
> >> -        /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
> >> -        if (!mis->postcopy_tmp_zero_page) {
> >> -            mis->postcopy_tmp_zero_page = mmap(NULL, mis->largest_page_size,
> >> -                                               PROT_READ | PROT_WRITE,
> >> -                                               MAP_PRIVATE | MAP_ANONYMOUS,
> >> -                                               -1, 0);
> >> -            if (mis->postcopy_tmp_zero_page == MAP_FAILED) {
> >> -                int e = errno;
> >> -                mis->postcopy_tmp_zero_page = NULL;
> >> -                error_report("%s: %s mapping large zero page",
> >> -                             __func__, strerror(e));
> >> -                return -e;
> >> -            }
> >> -            memset(mis->postcopy_tmp_zero_page, '\0', mis->largest_page_size);
> >> -        }
> >> -        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page,
> >> -                                   rb);
> >> +        return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_page, rb);
> >>      }
> >>  }
> >>  
> >> -- 
> >> 2.17.1
> >> 
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

