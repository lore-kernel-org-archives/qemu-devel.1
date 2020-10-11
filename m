Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43165C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99AD0207FB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpiH5UAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99AD0207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRVov-0004eY-O4
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 03:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRVnI-00044p-Fg
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kRVnF-0002mE-8Z
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 03:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602401358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EukZMor/4zhpLBCTClJNKoCARtZ10v2yP3vMMY5YbeQ=;
 b=PpiH5UAohajJupE5P53CcRUx/o+7EJgHCPLpWufdaSdXTFidvJrh2pJ1lDLDyiV9duEunF
 JZkUrjfK3tkHaSzqs1l5GKIV4wOsNWuVbOiCDgNnp8YlDvj3iD3tawQWhi7CnaaIVCtQ21
 Zmzvy7OdVNRWo+Mv5hCIrZqYJW0o6es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-sFvNnduiOL-dcplo7VOcwQ-1; Sun, 11 Oct 2020 03:29:16 -0400
X-MC-Unique: sFvNnduiOL-dcplo7VOcwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 580AA80F044;
 Sun, 11 Oct 2020 07:29:15 +0000 (UTC)
Received: from starship (unknown [10.35.206.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F55946;
 Sun, 11 Oct 2020 07:29:06 +0000 (UTC)
Message-ID: <47ead258320536d00f9f32891da3810040875aff.camel@redhat.com>
Subject: Re: Why guest physical addresses are not the same as the
 corresponding host virtual addresses in QEMU/KVM? Thanks!
From: Maxim Levitsky <mlevitsk@redhat.com>
To: harry harry <hiharryharryharry@gmail.com>, qemu-devel@nongnu.org, 
 mathieu.tarral@protonmail.com, stefanha@redhat.com, libvir-list@redhat.com,
 kvm@vger.kernel.org, pbonzini@redhat.com
Date: Sun, 11 Oct 2020 10:29:05 +0300
In-Reply-To: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
References: <CA+-xGqMd4_58_+QKetjOsubBqrDnaYF+YWE3TC3kEcNGxPiPfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 02:10:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PLING_QUERY=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2020-10-11 at 01:26 -0400, harry harry wrote:
> Hi QEMU/KVM developers,
> 
> I am sorry if my email disturbs you. I did an experiment and found the
> guest physical addresses (GPAs) are not the same as the corresponding
> host virtual addresses (HVAs). I am curious about why; I think they
> should be the same. I am very appreciated if you can give some
> comments and suggestions about 1) why GPAs and HVAs are not the same
> in the following experiment; 2) are there any better experiments to
> look into the reasons? Any other comments/suggestions are also very
> welcome. Thanks!
> 
> The experiment is like this: in a single vCPU VM, I ran a program
> allocating and referencing lots of pages (e.g., 100*1024) and didn't
> let the program terminate. Then, I checked the program's guest virtual
> addresses (GVAs) and GPAs through parsing its pagemap and maps files
> located at /proc/pid/pagemap and /proc/pid/maps, respectively. At
> last, in the host OS, I checked the vCPU's pagemap and maps files to
> find the program's HVAs and host physical addresses (HPAs); I actually
> checked the new allocated physical pages in the host OS after the
> program was executed in the guest OS.
> 
> With the above experiment, I found GPAs of the program are different
> from its corresponding HVAs. BTW, Intel EPT and other related Intel
> virtualization techniques were enabled.
> 
> Thanks,
> Harry
> 
The fundemental reason is that some HVAs (e.g. QEMU's virtual memory addresses) are already allocated
for qemu's own use (e.g qemu code/heap/etc) prior to the guest starting up. 

KVM does though use quite effiecient way of mapping HVA's to GPA. It uses an array of arbitrary sized HVA areas
(which we call memslots) and for each such area/memslot you specify the GPA to map to. In theory QEMU 
could allocate the whole guest's memory in one contiguous area and map it as single memslot to the guest. 
In practice there are MMIO holes, and various other reasons why there will be more that 1 memslot.
 
Best regards,
	Maxim Levitsky


