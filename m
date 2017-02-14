Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcyP-0004Ud-Ow
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdcyM-0005qK-KM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:16:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdcyM-0005pj-F8
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:16:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0A5D4DD58
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 13:16:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <25e714f1-fc75-9442-d5b3-5d579e484882@redhat.com> (Paolo
	Bonzini's message of "Tue, 14 Feb 2017 14:02:39 +0100")
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-12-git-send-email-quintela@redhat.com>
	<25e714f1-fc75-9442-d5b3-5d579e484882@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Feb 2017 14:16:36 +0100
Message-ID: <871sv052vf.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 11/12] migration: Send the fd number which
 we are going to use for this page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 13/02/2017 18:19, Juan Quintela wrote:
>>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>> +            fd_num = qemu_get_be16(f);
>> +            multifd_recv_page(host, fd_num);
>>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>>              break;
>
> Why do you need RAM_SAVE_FLAG_MULTIFD_PAGE?  I understand the
> orchestration of sent pages from a single thread, but could the receive
> threads proceed independently, each reading its own socket?  They do not
> even need to tell the central thread "I'm done" (they can do so just by
> exiting, and the central thread does qemu_thread_join when it sees the
> marker for end of live data).

We can send multiple sends in one go, the whole idea was to send the
pages "aligned", and being able to read also in place on destination.

But this showed that we still have bottlenecks on the code that search
for pages :-(

Later, Juan.
