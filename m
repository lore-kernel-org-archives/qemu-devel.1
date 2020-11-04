Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5315C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8942071A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 02:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvOQCG50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8942071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka8LA-0002ev-5R
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 21:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka8KU-0002DD-7V
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 21:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ka8KS-0007zR-BD
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 21:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604456115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcCelvENtzzTasIe59XfnvMhSV6K5TB1bs4yMVPMv+Y=;
 b=RvOQCG508wkYaF5aDZ+avJPKh8A96LfbDjwxRnWKmaNbjBtKBD4go+jf/G+M4h67Wylba6
 ijvd+zXQ26whkPd5kvUUWB8fUQN30vqFDhSUsiW10yjqTPKMdA+JduJd1obynwz/ZTqKW2
 BX7QaYWg1hq3jDpLBiXwbCjm1WjNiMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-iVn9CxWsO92y29etiaiW7A-1; Tue, 03 Nov 2020 21:15:13 -0500
X-MC-Unique: iVn9CxWsO92y29etiaiW7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90415F9D1;
 Wed,  4 Nov 2020 02:15:11 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82FCA5C1D0;
 Wed,  4 Nov 2020 02:15:06 +0000 (UTC)
Subject: Re: [RFC PATCH 0/6] eBPF RSS support for virtio-net
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20201102185115.7425-1-andrew@daynix.com>
 <0164a42f-4542-6f3e-bd71-3319dfaae190@redhat.com>
 <CAOEp5Oe3btwgPcOA6v=kK9s2to=x2Hg6Qw2iCFXOOWZs49s=-Q@mail.gmail.com>
 <20201103115602.GI205187@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e9037f4d-3a11-753e-79f7-195db652a6d2@redhat.com>
Date: Wed, 4 Nov 2020 10:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103115602.GI205187@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yan Vugenfirer <yan@daynix.com>, Andrew Melnychenko <andrew@daynix.com>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/11/3 下午7:56, Daniel P. Berrangé wrote:
> On Tue, Nov 03, 2020 at 12:32:43PM +0200, Yuri Benditovich wrote:
>> On Tue, Nov 3, 2020 at 11:02 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>>> On 2020/11/3 上午2:51, Andrew Melnychenko wrote:
>>>> Basic idea is to use eBPF to calculate and steer packets in TAP.
>>>> RSS(Receive Side Scaling) is used to distribute network packets to guest
>>> virtqueues
>>>> by calculating packet hash.
>>>> eBPF RSS allows us to use RSS with vhost TAP.
>>>>
>>>> This set of patches introduces the usage of eBPF for packet steering
>>>> and RSS hash calculation:
>>>> * RSS(Receive Side Scaling) is used to distribute network packets to
>>>> guest virtqueues by calculating packet hash
>>>> * eBPF RSS suppose to be faster than already existing 'software'
>>>> implementation in QEMU
>>>> * Additionally adding support for the usage of RSS with vhost
>>>>
>>>> Supported kernels: 5.8+
>>>>
>>>> Implementation notes:
>>>> Linux TAP TUNSETSTEERINGEBPF ioctl was used to set the eBPF program.
>>>> Added eBPF support to qemu directly through a system call, see the
>>>> bpf(2) for details.
>>>> The eBPF program is part of the qemu and presented as an array of bpf
>>>> instructions.
>>>> The program can be recompiled by provided Makefile.ebpf(need to adjust
>>>> 'linuxhdrs'),
>>>> although it's not required to build QEMU with eBPF support.
>>>> Added changes to virtio-net and vhost, primary eBPF RSS is used.
>>>> 'Software' RSS used in the case of hash population and as a fallback
>>> option.
>>>> For vhost, the hash population feature is not reported to the guest.
>>>>
>>>> Please also see the documentation in PATCH 6/6.
>>>>
>>>> I am sending those patches as RFC to initiate the discussions and get
>>>> feedback on the following points:
>>>> * Fallback when eBPF is not supported by the kernel
>>>
>>> Yes, and it could also a lacking of CAP_BPF.
>>>
>>>
>>>> * Live migration to the kernel that doesn't have eBPF support
>>>
>>> Is there anything that we needs special treatment here?
>>>
>>> Possible case: rss=on, vhost=on, source system with kernel 5.8 (everything
>> works) -> dest. system 5.6 (bpf does not work), the adapter functions, but
>> all the steering does not use proper queues.
>>
>>
>>
>>
>>>> * Integration with current QEMU build
>>>
>>> Yes, a question here:
>>>
>>> 1) Any reason for not using libbpf, e.g it has been shipped with some
>>> distros
>>>
>> We intentionally do not use libbpf, as it present only on some distros.
>> We can switch to libbpf, but this will disable bpf if libbpf is not
>> installed
> If we were modifying existing funtionality then introducing a dep on
> libbpf would be a problem as you'd be breaking existing QEMU users
> on distros without libbpf.
>
> This is brand new functionality though, so it is fine to place a
> requirement on libbpf. If distros don't ship that library and they
> want BPF features in QEMU, then those distros should take responsibility
> for adding libbpf to their package set.
>
>>> 2) It would be better if we can avoid shipping bytecodes
>>>
>>
>> This creates new dependencies: llvm + clang + ...
>> We would prefer byte code and ability to generate it if prerequisites are
>> installed.
> I've double checked with Fedora, and generating the BPF program from
> source is a mandatory requirement for QEMU. Pre-generated BPF bytecode
> is not permitted.
>
> There was also a question raised about the kernel ABI compatibility
> for BPF programs ?
>
>    https://lwn.net/Articles/831402/
>
>    "The basic problem is that when BPF is compiled, it uses a set
>     of kernel headers that describe various kernel data structures
>     for that particular version, which may be different from those
>     on the kernel where the program is run. Until relatively recently,
>     that was solved by distributing the BPF as C code along with the
>     Clang compiler to build the BPF on the system where it was going
>     to be run."
>
> Is this not an issue for QEMU's usage of BPF here ?


That's good point. Actually, DPDK ships RSS bytecodes but I don't know 
it works.

But as mentioned in the link, if we generate the code with BTF that 
would be fine.

Thanks


>
> The dependancy on llvm is unfortunate for people who build with GCC,
> but at least they can opt-out via a configure switch if they really
> want to. As that LWN article notes, GCC will gain BPF support
>
>
> Regards,
> Daniel


