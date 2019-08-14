Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356D3C32757
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AC7205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dWWov+CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AC7205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy0rs-0005FG-57
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 17:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.j.williams@intel.com>) id 1hy0qA-0004gJ-HM
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 17:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.j.williams@intel.com>) id 1hy0q8-0006Fy-DJ
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 17:29:53 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
 id 1hy0q2-00068e-7K
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 17:29:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id l12so218272oil.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 14:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dV5iSaTLF6GvE1k736/fv/IO+wacAWP05FLSNalcmJ8=;
 b=dWWov+CPj4KHZ2zkB4yMAgJZjhzXOYsHzWu7cuyWYpM2n7cQWjcsdZxHEMBrt+Cff3
 Zv0fU2oSRAh/pymJpfTdbVWtSL53Q4Tuvf0sseHjQa5ff80YiXrDad/DOQ6dBS3O0xnK
 0UnpXbEalE7sk++eozdaiBh8/orESxXg71dd/q1PaihByqqwwqs9eQ606/RYMPlutmVr
 VJ8rqWTQrIxxJP8prkwqUj+wIK15An+poR6qHzlQ8/8eYLs7xiql4aGIvZkrIkSpcQ58
 FFiG0PKwkhkpFbgI5T0RLMX8vjb5VVzXMsI3AjV836+x7dq+xKvErfo4ePRT9BwR01OK
 Fs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dV5iSaTLF6GvE1k736/fv/IO+wacAWP05FLSNalcmJ8=;
 b=Rq0LHAC+zRB5tb8dx+v3YQMOHPmdZyBCYhbgz0vGuwJJlrPdUApCaSeerbSiOe85v4
 +ga5PchMaalQ8RLYNsqJe7tBcDzAEIM2mD4ANFkuPQQPMGRY/NSHvn42SjMYBwHdmQWV
 CfFd9p8XarDQG9r6AcO35iRYFpNgbUFW6/0Jep9noYN8ZdGSDzVOi9D7QKTeNvFUuNRC
 x85f9052LcsdEuUhPp5RIGiGY6abjI6A/Wck3u7HBZKjGR15WoWVQZYzUXqBtOMIM5V4
 4l003l5ZUyLpKX/88TCvAhTJ3r8MKSJZJFl23q+cIDrjwU9qmyiu7jF8+qOq/1LY8Xvy
 yIaA==
X-Gm-Message-State: APjAAAXeYjptT/aujz9Hm+VkrBE4fuaLeWv2gLvgcRVbQi9fc7oC4K6Y
 Td4IOPvZG/NfOOiRG+1XodpP8lJxwWuj4oh59QcIjQ==
X-Google-Smtp-Source: APXvYqxlI4/GNJQrDZIlRpfZJ7baVdNHJY8dldUcIYGoLK4kt0EGmPKzZF7LA5r2taVGkn2tvAC5NL3KnzESyWuaxYk=
X-Received: by 2002:a05:6808:914:: with SMTP id
 w20mr1278133oih.73.1565818182510; 
 Wed, 14 Aug 2019 14:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-6-tao3.xu@intel.com>
 <20190813170027.0617b129@redhat.com>
 <CAPcyv4j=wBtBcscJBtrMNDDz=d6+HYYDF=4QLU69d0EPMkTTqg@mail.gmail.com>
 <a73f7c81-0363-c10f-8ae1-9344abc55449@intel.com>
In-Reply-To: <a73f7c81-0363-c10f-8ae1-9344abc55449@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Aug 2019 14:29:31 -0700
Message-ID: <CAPcyv4jCuy6zvM8NcacXhvpUBUyp_BYMcEtBuA_ck3AhkyGNsQ@mail.gmail.com>
To: Tao Xu <tao3.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v9 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Jingqi Liu <jingqi.liu@intel.com>,
 "Du, Fan" <fan.du@intel.com>, Qemu Developers <qemu-devel@nongnu.org>,
 daniel@linux.ibm.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 10:14 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> On 8/14/2019 10:39 AM, Dan Williams wrote:
> > On Tue, Aug 13, 2019 at 8:00 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >>
> >> On Fri,  9 Aug 2019 14:57:25 +0800
> >> Tao <tao3.xu@intel.com> wrote:
> >>
> >>> From: Tao Xu <tao3.xu@intel.com>
> >>>
> >>> In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
> >>> The initiator represents processor which access to memory. And in 5.2.27.3
> >>> Memory Proximity Domain Attributes Structure, the attached initiator is
> >>> defined as where the memory controller responsible for a memory proximity
> >>> domain. With attached initiator information, the topology of heterogeneous
> >>> memory can be described.
> >>>
> >>> Extend CLI of "-numa node" option to indicate the initiator numa node-id.
> >>> In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
> >>> the platform's HMAT tables.
> >>>
> >>> Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
> >>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> >>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>> ---
> >>>
> >>> No changes in v9
> >>> ---
> >>>   hw/core/machine.c     | 24 ++++++++++++++++++++++++
> >>>   hw/core/numa.c        | 13 +++++++++++++
> >>>   include/sysemu/numa.h |  3 +++
> >>>   qapi/machine.json     |  6 +++++-
> >>>   qemu-options.hx       | 27 +++++++++++++++++++++++----
> >>>   5 files changed, 68 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >>> index 3c55470103..113184a9df 100644
> >>> --- a/hw/core/machine.c
> >>> +++ b/hw/core/machine.c
> >>> @@ -640,6 +640,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
> >>>                                  const CpuInstanceProperties *props, Error **errp)
> >>>   {
> >>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> >>> +    NodeInfo *numa_info = machine->numa_state->nodes;
> >>>       bool match = false;
> >>>       int i;
> >>>
> >>> @@ -709,6 +710,16 @@ void machine_set_cpu_numa_node(MachineState *machine,
> >>>           match = true;
> >>>           slot->props.node_id = props->node_id;
> >>>           slot->props.has_node_id = props->has_node_id;
> >>> +
> >>> +        if (numa_info[props->node_id].initiator_valid &&
> >>> +            (props->node_id != numa_info[props->node_id].initiator)) {
> >>> +            error_setg(errp, "The initiator of CPU NUMA node %" PRId64
> >>> +                       " should be itself.", props->node_id);
> >>> +            return;
> >>> +        }
> >>> +        numa_info[props->node_id].initiator_valid = true;
> >>> +        numa_info[props->node_id].has_cpu = true;
> >>> +        numa_info[props->node_id].initiator = props->node_id;
> >>>       }
> >>>
> >>>       if (!match) {
> >>> @@ -1050,6 +1061,7 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
> >>>       GString *s = g_string_new(NULL);
> >>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> >>>       const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(machine);
> >>> +    NodeInfo *numa_info = machine->numa_state->nodes;
> >>>
> >>>       assert(machine->numa_state->num_nodes);
> >>>       for (i = 0; i < possible_cpus->len; i++) {
> >>> @@ -1083,6 +1095,18 @@ static void machine_numa_finish_cpu_init(MachineState *machine)
> >>>               machine_set_cpu_numa_node(machine, &props, &error_fatal);
> >>>           }
> >>>       }
> >>> +
> >>> +    for (i = 0; i < machine->numa_state->num_nodes; i++) {
> >>> +        if (numa_info[i].initiator_valid &&
> >>> +            !numa_info[numa_info[i].initiator].has_cpu) {
> >>                            ^^^^^^^^^^^^^^^^^^^^^^ possible out of bounds read, see bellow
> >>
> >>> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> >>> +                         " does not exist.", numa_info[i].initiator, i);
> >>> +            error_printf("\n");
> >>> +
> >>> +            exit(1);
> >>> +        }
> >> it takes care only about nodes that have cpus or memory-only ones that have
> >> initiator explicitly provided on CLI. And leaves possibility to have
> >> memory-only nodes without initiator mixed with nodes that have initiator.
> >> Is it valid to have mixed configuration?
> >> Should we forbid it?
> >
> > The spec talks about the "Proximity Domain for the Attached Initiator"
> > field only being valid if the memory controller for the memory can be
> > identified by an initiator id in the SRAT. So I expect the only way to
> > define a memory proximity domain without this local initiator is to
> > allow specifying a node-id that does not have an entry in the SRAT.
> >
> Hi Dan,
>
> So there may be a situation for the Attached Initiator field is not
> valid? If true, I would allow user to input Initiator invalid.

Yes it's something the OS needs to consider because the platform may
not be able to meet the constraint that a single initiator is
associated with the memory controller for a given memory target. In
retrospect it would have been nice if the spec reserved 0xffffffff for
this purpose, but it seems "not in SRAT" is the only way to identify
memory that is not attached to any single initiator.

> > That would be a useful feature for testing OS HMAT parsing behavior,
> > and may match platforms that exist in practice.

