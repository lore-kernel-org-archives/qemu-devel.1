Received: from eggs.gnu.org ([2001:4830:134:3::10]:53408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdckk-0001zO-2o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdckh-0004qI-18
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:02:42 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdckg-0004q0-RV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:02:38 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so3457353wmv.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 05:02:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-12-git-send-email-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25e714f1-fc75-9442-d5b3-5d579e484882@redhat.com>
Date: Tue, 14 Feb 2017 14:02:39 +0100
MIME-Version: 1.0
In-Reply-To: <1487006388-7966-12-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com



On 13/02/2017 18:19, Juan Quintela wrote:
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
> +            fd_num = qemu_get_be16(f);
> +            multifd_recv_page(host, fd_num);
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;

Why do you need RAM_SAVE_FLAG_MULTIFD_PAGE?  I understand the
orchestration of sent pages from a single thread, but could the receive
threads proceed independently, each reading its own socket?  They do not
even need to tell the central thread "I'm done" (they can do so just by
exiting, and the central thread does qemu_thread_join when it sees the
marker for end of live data).

Paolo
