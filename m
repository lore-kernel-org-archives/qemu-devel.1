Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E89C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDA220727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0jzqKai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDA220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJEj-0002dr-C1
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBJDy-0002CS-Eo
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBJDx-00072O-Bd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:17:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBJDx-000721-7O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583763460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uYqdCRnX+ON8p6JRcuVA+jii+YDfupDg5riFJtGgG9Y=;
 b=h0jzqKai+olJhJPfffXZbh4lyzgbw4GumX7+TlVH+3EEkTP7UYLiqROvJTtqX20e/ij3w+
 dkvOUnUQJ+oa1dEkL0jcVPyJl2jeARVON0J1w2w5QkZNZyXFzvedwqksOgUf69MUQmXA9L
 MnXvUhJiaFT3CZ8P0kMJj26PIYxS/pI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-USVsfRTPMsCHcozq6W3MmA-1; Mon, 09 Mar 2020 10:17:39 -0400
X-MC-Unique: USVsfRTPMsCHcozq6W3MmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16FB4100550D;
 Mon,  9 Mar 2020 14:17:38 +0000 (UTC)
Received: from Igors-MacBook-Pro (ovpn-206-77.brq.redhat.com [10.40.206.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FDBD1001DC0;
 Mon,  9 Mar 2020 14:17:33 +0000 (UTC)
Date: Mon, 9 Mar 2020 15:17:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 04/16] machine: Add SMP Sockets in CpuTopology
Message-ID: <20200309151730.587ec11d@Igors-MacBook-Pro>
In-Reply-To: <158326543822.40452.17598145031344735065.stgit@naples-babu.amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326543822.40452.17598145031344735065.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Mar 2020 13:57:18 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Store the  smp sockets in CpuTopology. The socket information required to
> build the apic id in EPYC mode. Right now socket information is not passed
> to down when decoding the apic id. Add the socket information here.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/machine.c   |    1 +
>  hw/i386/pc.c        |    1 +
>  include/hw/boards.h |    2 ++
>  vl.c                |    1 +

this has been moved to softmmu, so patch needs to rebased against current master

>  4 files changed, 5 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index d8e30e4895..2582ce94f6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -728,6 +728,7 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>      }
>  
>      if (ms->smp.cpus > 1) {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index ef23ae2af5..68bf08f285 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -780,6 +780,7 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
>          ms->smp.cpus = cpus;
>          ms->smp.cores = cores;
>          ms->smp.threads = threads;
> +        ms->smp.sockets = sockets;
>          x86ms->smp_dies = dies;
>      }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index fb1b43d5b9..320dd14e02 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -252,12 +252,14 @@ typedef struct DeviceMemoryState {
>   * @cpus: the number of present logical processors on the machine
>   * @cores: the number of cores in one package
>   * @threads: the number of threads in one core
> + * @sockets: the number of sockets on the machine
>   * @max_cpus: the maximum number of logical processors on the machine
>   */
>  typedef struct CpuTopology {
>      unsigned int cpus;
>      unsigned int cores;
>      unsigned int threads;
> +    unsigned int sockets;
>      unsigned int max_cpus;
>  } CpuTopology;
>  
> diff --git a/vl.c b/vl.c
> index 7dcb0879c4..f77b1285c6 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3949,6 +3949,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->smp.max_cpus = machine_class->default_cpus;
>      current_machine->smp.cores = 1;
>      current_machine->smp.threads = 1;
> +    current_machine->smp.sockets = 1;
>  
>      machine_class->smp_parse(current_machine,
>          qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
> 


