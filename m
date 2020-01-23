Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F7EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83ABA21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bglxpFre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83ABA21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiNW-0003Tl-Mz
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iugSI-0008VM-If
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iugSF-0004Tl-Iu
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:39:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iugSF-0004SJ-DX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHJZS6rMsl/fh3OnHqPGqDK8MS1Ifj/AVVwz0OkIGnA=;
 b=bglxpFre4alr6jrVzD+Ue5fQ/wlRNlDgOuR7JzG7SBVgObykzUHB9UnVdSmaUu/zxZPxGB
 7TpYWNmvR8Lit7CKCOsT6cy/7jaHCY2us1M582+eyBDcnODQ3kw7FbMC9KkwtUoj8QXFgk
 5DKKWDnj5IXlVoRGVpnErQNZ2JAnNXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-KzoGGUugPH2j95yTKj6wSA-1; Thu, 23 Jan 2020 12:14:37 -0500
Received: by mail-wm1-f72.google.com with SMTP id t16so1415737wmt.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 09:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HHJZS6rMsl/fh3OnHqPGqDK8MS1Ifj/AVVwz0OkIGnA=;
 b=d2JuyAlvduQi7FwJUBR6M2akt3yS0GTE94y/ucrzzinqskajcnVDJS2W2Uql0O0K5j
 zWc6eTKt0ONsYUf0IVo+XxwuuJNiQXNvYMyNjfH/wkajECpa289CnE/2nl5JIbtzUfqZ
 QgCDVDJrDszA2lG22a0RfhAgscpISQmn+UI1HQ45FT77RtCmhrTq1vIzD9tVSZLhgOcs
 L42EQkAu7nBKrkL9ReShF4x+oIV9neI9RN0PnpklAMbDIf+9nSaU7nAskcWM8RqvIfGj
 qmsLVbJTDv7APYmV3BhoI3cQMD1DXCa7NdC0/dlHZgRxuLZ2GEOjP8W5W5OP/sMZdWaJ
 fyCw==
X-Gm-Message-State: APjAAAWbn3AQPkeQchNaeLa1vSrmaA5NOLeLCCKH/q3XCzDAB76B/RgS
 UWlDu0dbziZJpMjyhYi187ikNkTkbnWHlNjTgntMd5bI0JDW8E6DfnU6YGZXUGWM6NyGmvDBzy5
 +foLNryIC24AvSLE=
X-Received: by 2002:adf:c74f:: with SMTP id b15mr18395090wrh.272.1579799676463; 
 Thu, 23 Jan 2020 09:14:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjAZtLFtAv+z8aSZKCLK4U0wqBC6GmlttxNDXJssD729uozWQbSVUv1SW4bAvrpKf3st2+/Q==
X-Received: by 2002:adf:c74f:: with SMTP id b15mr18395049wrh.272.1579799675953; 
 Thu, 23 Jan 2020 09:14:35 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id e8sm3788413wrt.7.2020.01.23.09.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 09:14:35 -0800 (PST)
Subject: Re: [qemu-web PATCH v2] Add "Security Process" information to the
 main website
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200123171150.12782-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3281f4df-f7c9-bdf2-5a1e-0b1d2ff63d6f@redhat.com>
Date: Thu, 23 Jan 2020 18:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123171150.12782-1-thuth@redhat.com>
Content-Language: en-US
X-MC-Unique: KzoGGUugPH2j95yTKj6wSA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: pjp@redhat.com, sstabellini@kernel.org, pmatouse@redhat.com,
 mdroth@linux.vnet.ibm.com, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/20 18:11, Thomas Huth wrote:
> One reporter of a security issue recently complained that it might not
> be the best idea to store our "Security Process" in the Wiki. Well, while
> the page in the Wiki is protected (so that only some few people can edit
> it), it is still possible that someone might find a bug in the Wiki
> software to alter the page contents...
> Anyway, it looks more trustworthy if we present the "Security Process"
> information in the static website instead. Thus this patch adds the
> information from the wiki to the Jekyll-based website now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  v2: Improved some sentences as suggested by Paolo
> 
>  contribute.md                  |   3 +-
>  contribute/report-a-bug.md     |   7 +-
>  contribute/security-process.md | 129 +++++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+), 5 deletions(-)
>  create mode 100644 contribute/security-process.md
> 
> diff --git a/contribute.md b/contribute.md
> index 56306e0..96901b5 100644
> --- a/contribute.md
> +++ b/contribute.md
> @@ -3,7 +3,8 @@ title: Contribute to QEMU!
>  permalink: /contribute/
>  ---
>  
> -* Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)
> +* Report a bug in our bugtracker: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>
> +  See also [How to report a bug](report-a-bug/) or [How to report a security bug](security-process/)
>  
>  * Clone ([or browse](https://git.qemu.org/?p=qemu.git)) the git repository: <br>`git clone https://git.qemu.org/git/qemu.git`
>  
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index 441c61b..1cc42e7 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -17,10 +17,9 @@ When submitting a bug report, please try to do the following:
>  
>  * Do not contribute patches on the bug tracker; send patches to the mailing list. Follow QEMU's [guidelines about submitting patches](https://wiki.qemu.org/Contribute/SubmitAPatch).
>  
> -Do NOT report security issues (or other bugs, too) as
> -"private" bugs in the bug tracker.  QEMU has a [security
> -process](https://wiki.qemu.org/SecurityProcess) for issues that should
> -be reported in a non-public way instead.
> +Do NOT report security issues (or other bugs, too) as "private" bugs in the
> +bug tracker.  QEMU has a [security process](../security-process) for issues
> +that should be reported in a non-public way instead.
>  
>  For problems with KVM in the kernel, use the kernel bug tracker instead;
>  the [KVM wiki](https://www.linux-kvm.org/page/Bugs) has the details.
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> new file mode 100644
> index 0000000..ad10627
> --- /dev/null
> +++ b/contribute/security-process.md
> @@ -0,0 +1,129 @@
> +---
> +title: Security Process
> +permalink: /contribute/security-process/
> +---
> +
> +QEMU takes security very seriously, and we aim to take immediate action to
> +address serious security-related problems that involve our product.
> +
> +Please report any suspected security vulnerability in QEMU to the following
> +addresses. You can use GPG keys for respective receipients to communicate with
> +us securely. If you do, please upload your GPG public key or supply it to us
> +in some other way, so that we can communicate to you in a secure way, too!
> +Please include the tag **\[QEMU-SECURITY\]** on the subject line to help us
> +identify your message as security-related. 
> +
> +## QEMU Security Contact List
> +
> +Please copy everyone on this list:
> +
> + Contact Person(s)	| Contact Address		| Company	|  GPG Key  | GPG key fingerprint
> +:-----------------------|:------------------------------|:--------------|:---------:|:--------------------
> + Michael S. Tsirkin	| mst@redhat.com		| Red Hat Inc.	| [&#x1f511;](https://pgp.mit.edu/pks/lookup?op=vindex&search=0xC3503912AFBE8E67) | 0270 606B 6F3C DF3D 0B17 0970 C350 3912 AFBE 8E67
> + Petr Matousek		| pmatouse@redhat.com		| Red Hat Inc.	| [&#x1f511;](https://pgp.mit.edu/pks/lookup?op=vindex&search=0x3E786F42C44977CA) | 8107 AF16 A416 F9AF 18F3 D874 3E78 6F42 C449 77CA
> + Stefano Stabellini	| sstabellini@kernel.org 	| Independent	| [&#x1f511;](https://pgp.mit.edu/pks/lookup?op=vindex&search=0x894F8F4870E1AE90) | D04E 33AB A51F 67BA 07D3 0AEA 894F 8F48 70E1 AE90
> + Security Response Team | secalert@redhat.com		| Red Hat Inc.	| [&#x1f511;](https://access.redhat.com/site/security/team/contact/#contact) |
> + Michael Roth		| mdroth@linux.vnet.ibm.com	| IBM		| [&#x1f511;](https://pgp.mit.edu/pks/lookup?op=vindex&search=0x3353C9CEF108B584) | CEAC C9E1 5534 EBAB B82D 3FA0 3353 C9CE F108 B584
> + Prasad J Pandit 	| pjp@redhat.com		| Red Hat Inc.	| [&#x1f511;](http://pool.sks-keyservers.net/pks/lookup?op=vindex&search=0xE2858B5AF050DE8D) | 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D 
> +
> +## How to Contact Us Securely
> +
> +We use GNU Privacy Guard (GnuPG or GPG) keys to secure communications. Mail
> +sent to members of the list can be encrypted with public keys of all members
> +of the list. We expect to change some of the keys we use from time to time.
> +Should a key change, the previous one will be revoked.
> +
> +## How we respond
> +
> +Maintainers listed on the security reporting list operate a policy of
> +responsible disclosure. As such they agree that any information you share with
> +them about security issues that are not public knowledge is kept confidential
> +within respective affiliated companies. It is not passed on to any third-party,
> +including Xen Security Project, without your permission.
> +
> +Email sent to us is read and acknowledged with a non-automated response. For
> +issues that are complicated and require significant attention, we will open an
> +investigation and keep you informed of our progress. We might take one or more
> +of the following steps:
> +
> +### Publication embargo
> +
> +As a security issue reported, that is not already publically disclosed
> +elsewhere, has an embargo date assigned and communicated to reporter. Embargo
> +periods will be negotiated by mutual agreement between members of the security
> +team and other relevant parties to the problem. Members of the security contact
> +list agree not to publically disclose any details of the security issue until
> +the embargo date expires.
> +
> +### CVE allocation
> +
> +An security issue is assigned with a CVE number. The CVE numbers will usually
> +be allocated by one of the vendor security engineers on the security contact
> +list.
> +
> +## When to contact the QEMU Security Contact List
> +
> +You should contact the Security Contact List if:
> +* You think there may be a security vulnerability in QEMU.
> +* You are unsure about how a known vulnerability affects QEMU.
> +* You can contact us in English. We are unable to respond in other languages.
> +
> +## When *not* to contact the QEMU Security Contact List
> +* You need assistance in a language other than English.
> +* You require technical assistance (for example, "how do I configure QEMU?").
> +* You need help upgrading QEMU due to security alerts.
> +* Your issue is not security related.
> +
> +## How impact and severity of a bug is decided
> +
> +All security issues in QEMU are not equal. Based on the parts of the QEMU
> +sources wherein the bug is found, its impact and severity could vary.
> +
> +In particular, QEMU is used in many different scenarios; some of them assume
> +that the guest is trusted, some of them don't. General considerations to triage
> +QEMU issues and decide whether a configuration is security sensitive include:
> +
> +* Is there any feasible way for a malicious party to exploit this flaw and
> +  cause real damage? (e.g. from a guest or via downloadable images)
> +* Does the flaw require access to the management interface? Would the
> +  management interface be accessible in the scenario where the flaw could cause
> +  real damage?
> +* Is QEMU used in conjunction with a hypervisor (as opposed to TCG binary
> +  translation)?
> +* Is QEMU used to offer virtualised production services, as opposed to usage
> +  as a development platform?
> +
> +Whenever some or all of these questions have negative answers, what appears to
> +be a major security flaw might be considered of low severity because it could
> +only be exercised in use cases where QEMU and everything interacting with it is
> +trusted.
> +
> +For  example, consider upstream commit [9201bb9 "sdhci.c: Limit the maximum
> +block size"](http://git.qemu.org/?p=qemu.git;a=commit;h=9201bb9), an of out of
> +bounds (OOB) memory access (ie. buffer overflow) issue that was found and fixed
> +in the SD Host  Controller emulation (hw/sd/sdhci.c).
> +
> +On the surface, this bug appears to be a genuine security flaw, with potentially
> +severe implications. But digging further down, there are only two ways to use
> +SD Host Controller emulation, one is via 'sdhci-pci' interface and the other
> +is via 'generic-sdhci' interface.
> +
> +Of these two, the 'sdhci-pci' interface had actually been disabled by default
> +in the upstream QEMU releases (commit [1910913 "sdhci: Make device "sdhci-pci"
> +unavailable with -device"](http://git.qemu.org/?p=qemu.git;a=commit;h=1910913)
> +at the time the flaw was reported; therefore, guests could not possibly use
> +'sdhci-pci' for any  purpose.
> +
> +The 'generic-sdhci' interface, instead, had only one user in 'Xilinx Zynq
> +Baseboard emulation' (hw/arm/xilinx_zynq.c). Xilinx Zynq is a programmable
> +systems on chip (SoC) device. While QEMU does emulate this device, in practice
> +it is used to facilitate cross-platform developmental efforts, i.e. QEMU is
> +used to write programs for the SoC device. In such developer environments, it
> +is generally assumed that the guest is trusted.
> +
> +And thus, this buffer overflow turned out to be a security non-issue.
> +
> +## What to Send to the QEMU Security Contact List
> +
> +Please provide as much information about your system and the issue as possible
> +when contacting the list.
> 


