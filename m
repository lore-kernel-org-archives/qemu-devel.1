Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16AC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7D52075E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZspwcTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7D52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKeiK-0001Mk-AL
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKecJ-0003Fl-Cj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:29:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKecD-0006VI-Rx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600766977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ULNjP3KZSveKrUPn00mHob+Zp8JX9+kVRsjglfAxW2o=;
 b=JZspwcTw7LGsQSgLEt5FwsMJk8liXMWP7HhO367TP0Jc7hhKJFhMs9wWUxJ6N8auLJAmRD
 0BiNOUHNamed8840IXVZG+cx6hvpxdlta995C5dzKi+eWpRn+KnNHieE3AH61d2ZUSyf6Z
 f4ZjOcbPN3YAUL9u54+bBxyizSUN4Zk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-khFBFnLCPkiZRcskvqQpiw-1; Tue, 22 Sep 2020 05:29:35 -0400
X-MC-Unique: khFBFnLCPkiZRcskvqQpiw-1
Received: by mail-wr1-f72.google.com with SMTP id 33so7193813wre.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 02:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ULNjP3KZSveKrUPn00mHob+Zp8JX9+kVRsjglfAxW2o=;
 b=M/f8oKG9teDpqXN9iIeXl6IYAsxvZOaF8KAevnlXLk0hQ3ZOxjUYsQRO4eaZWiRqTz
 rFV8f9xqqPPhzPG1tRRSA59VG+6MUaXJRwtdFys6g1An7jYq2ecsitB0UngUwJw6dcXm
 z78FSd76JW+hzbKl/GN88MnRQyNLiQvGSysOSPV1u6/AmgcNM7DDPqMz/op0gy8qsW9T
 q89DY3gln+XV2UpHMHbt5S/asP48vuG2wM+iJdcPu3NRYuwL7ieIRWeI0ObjrtrMSr6m
 4ubtv1o1jl7Gn6fkfh9sUPwi3YhMXNqn/vUMFAqeiEgu2bKkX9ohqLL5g5TXkVRD+4Xc
 4NaA==
X-Gm-Message-State: AOAM531R5xhVHbLxCin+NQYqzDq8HrDTk+Zc1Hblvkoc1kjfRYClx6CB
 FSqKd7IyCwkn0OUROeGtgv+/UVK0azFH5xILPl9umTs4U4zUYRoHYDNah/+FiC2D1PQg++FDmj3
 DpmLxETzrEzLdE2M=
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr4670302wrt.157.1600766974060; 
 Tue, 22 Sep 2020 02:29:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4LMeMiDmVhWIWgmAlkHvU5ghh+6oIF0e8Mbkqq65dQ7fbsfgKInWCmIY0V5wbf114cNWAMw==
X-Received: by 2002:a5d:60c6:: with SMTP id x6mr4670270wrt.157.1600766973757; 
 Tue, 22 Sep 2020 02:29:33 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l4sm896631wrc.14.2020.09.22.02.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 02:29:33 -0700 (PDT)
Subject: Re: [RFC DOCUMENT 00/12] kubevirt-and-kvm: Add documents
To: Andrea Bolognani <abologna@redhat.com>, libvir-list@redhat.com,
 qemu-devel@nongnu.org
References: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <83b1a4fd-9d06-8a9a-974b-6314d370db21@redhat.com>
Date: Tue, 22 Sep 2020 11:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a6b5e34843b3f08994d4ffefadc5867001e0bc36.camel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: crobinso@redhat.com, rmohr@redhat.com, vromanso@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrea,

On 9/16/20 6:44 PM, Andrea Bolognani wrote:
> Hello there!
> 
> Several weeks ago, a group of Red Hatters working on the
> virtualization stack (primarily QEMU and libvirt) started a
> conversation with developers from the KubeVirt project with the goal
> of better understanding and documenting the interactions between the
> two.
> 
> Specifically, we were interested in integration pain points, with the
> underlying ideas being that only once those issues are understood it
> becomes possible to look for solutions, and that better communication
> would naturally lead to improvements on both sides.
> 
> This series of documents was born out of that conversation. We're
> sharing them with the QEMU and libvirt communities in the hope that
> they can be a valuable resource for understanding how the projects
> they're working on are consumed by higher-level tools, and what
> challenges are encountered in the process.
> 
> Note that, while the documents describe a number of potential
> directions for things like development of new components, that's all
> just brainstorming that naturally occurred as we were learning new
> things: the actual design process should, and will, happen on the
> upstream lists.
> 
> Right now the documents live in their own little git repository[1],
> but the expectation is that eventually they will find a suitable
> long-term home. The most likely candidate right now is the main
> KubeVirt repository, but if you have other locations in mind please
> do speak up!
> 
> I'm also aware of the fact that this delivery mechanism is fairly
> unconventional, but I thought it would be the best way to spark a
> discussion around these topics with the QEMU and libvirt developers.
> 
> Last but not least, please keep in mind that the documents are a work
> in progress, and polish has been applied to them unevenly: while the
> information presented is, to the best of our knowledge, all accurate,
> some parts are in a rougher state than others. Improvements will
> hopefully come over time - and if you feel like helping out in making
> that happen, it would certainly be appreciated!
> 
> Looking forward to your feedback :)
> 
> 
> [1] https://gitlab.com/abologna/kubevirt-and-kvm

Thanks a lot for this documentation, I could learn new things,
use cases out of my interest area. Useful as a developer to
better understand how are used the areas I'm coding. This
shorten a bit that gap between developers and users.

What would be more valuable than a developer review/feedback is
having feedback from users and technical writers.
Suggestion: also share it on qemu-discuss@nongnu.org which is
less technical (maybe simply repost the cover and link to the
Wiki).

--

What is not obvious in this cover (and the documents pasted on
the list) is there are schema pictures on the Wiki pages which
are not viewable and appreciable via an email post.

--

I had zero knowledge on Kubernetes. I have been confused by their
use in the introduction...

From Index:

"The intended audience is people who are familiar with the traditional
virtualization stack (QEMU plus libvirt), and in order to make it
more approachable to them comparisons, are included and little to no
knowledge of KubeVirt or Kubernetes is assumed."

Then in Architecture's {Goals and Components} there is an assumption
Kubernetes is known. Entering in Components, Kubernetes is briefly
but enough explained.

Then KubeVirt is very well explained.

--

Sometimes the "Other topics" category is confusing, it seems out
of the scope of the "better understanding and documenting the
interactions between KubeVirt and KVM" and looks like left over
notes. I.e.:

"Another possibility is to leverage the device-mapper from Linux to
provide features such as snapshots and even like Incremental Backup.
For example, dm-era seems to provide the basic primitives for
bitmap tracking.
This could be part of scenario number 1, or cascaded with other PVs
somewhere else.
Is this already being used? For example, cybozu-go/topolvm is a
CSI LVM Plugin for k8s."

"vhost-user-blk in other CSI backends
Would it make sense for other CSI backends to implement support for
vhost-user-blk?"

"The audience is people who are familiar with the traditional
virtualization stack (QEMU plus libvirt)". Feeling part of the
audience, I have no clue how to answer these questions...
I'd prefer you tell me :)

Maybe renaming the "Other topics" section would help.
"Unanswered questions", "Other possibilities to investigate",...

--

Very good contribution in documentation,

Thanks!

Phil.


