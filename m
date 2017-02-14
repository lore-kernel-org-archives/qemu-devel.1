Received: from eggs.gnu.org ([2001:4830:134:3::10]:49884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcfm-0005Wu-BZ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cdcfj-0001VX-CQ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:57:34 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cdcfj-0001V3-4S
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 07:57:31 -0500
Received: by mail-wm0-x244.google.com with SMTP id u63so3429242wmu.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 04:57:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
	<1487006388-7966-8-git-send-email-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf5674c1-ed30-ae39-1ab0-fcdbb4d2010a@redhat.com>
Date: Tue, 14 Feb 2017 13:57:31 +0100
MIME-Version: 1.0
In-Reply-To: <1487006388-7966-8-git-send-email-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 07/12] migration: Start of multiple fd work
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
> +        qemu_sem_init(&p->init, 0);
>          p->quit = false;
> +        p->c = socket_send_channel_create();
> +        if (!p->c) {
> +            error_report("Error creating a send channel");
> +            exit(0);
> +        }
>          snprintf(thread_name, 15, "multifd_send_%d", i);
>          qemu_thread_create(&p->thread, thread_name, multifd_send_thread, p,
>                             QEMU_THREAD_JOINABLE);
> +        qemu_sem_wait(&p->init);

Why do you need p->init here?  Could initialization proceed in parallel
for all the threads?

Paolo
