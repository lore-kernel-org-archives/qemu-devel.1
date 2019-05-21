Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E9C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 17:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAEE21019
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 17:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAEE21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT8Nt-0007Qv-Ip
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 13:17:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT8LV-0005zM-7D
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT8LT-0006sY-9t
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hT8LR-0006pN-Ae
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so19520917wrs.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 10:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MlJIziyZYc+D+9Ag4uJPd28IRhqDk3bXMjby/zgEfts=;
	b=LZdsYUs7Vs9YzZLioOlJH5+W0/FJQsZ0L5FAKV7cIqTJO72KwXU3T8BC7FcJBo189i
	EYQK+FKfVcYCX91nRqUO7OnQRizEgmhgzTJhjkrmWkMBZZ6GrzS88dM/w/Kers22bg+M
	p7b4KhZT9vP4+GV814j9y3b4hZxDAbgkdqx1VV4tL5K1jCcmjM7ovF++AIKySSEkZn0I
	XBDDHlQyly5qm42c1IGlZVPMCtQNuxdgr3+xjUKLd9qVab/FfMTBzzXL4eA15NfrxSmI
	r9sny+9d6X/9dCMVMppiHOcnJ8yTk0qs06/IThJ1e3Nv65qIgbf3ovcSfOTAzysHYWhd
	m9MA==
X-Gm-Message-State: APjAAAWEUYFcnGzXQIa/pgK4kslCJgZsDSiuxHKvGQdUdTHxyDHaq5vj
	Q1rbsNKfjxlyB5jLw/PYUf3mEg==
X-Google-Smtp-Source: APXvYqwXCWSXuRMA8rMgLLJNx70pFWFh3cVBKzQ+IiUqrJv38ziST/UevG3oLjaA//anOTWh0h3z7A==
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr32909780wrm.153.1558458871146;
	Tue, 21 May 2019 10:14:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	f11sm18711731wrv.93.2019.05.21.10.14.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 10:14:30 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<20190521161724.GI10764@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8c413c1-ffa3-c00a-86d2-6383ca5e82c8@redhat.com>
Date: Tue, 21 May 2019 19:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521161724.GI10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 18:17, Eduardo Habkost wrote:
> On Tue, May 21, 2019 at 12:55:36PM +0200, Paolo Bonzini wrote:
>> On 21/05/19 10:53, Daniel P. Berrangé wrote:
>>> Hawkmoth seems pretty attractive in its output format, but doesn't appear
>>> to be part of either Debian or Fedora distros, so we would have to bundle
>>> it in QEMU I expect.  My big concern there is that there have only been
>>> 2 contributors to Hawkmoth in its entire 3 year existance, which makes
>>> me fear for its long term viability if the main author gives up.
>>
>> On the plus side, I think the main author is among the people that
>> pushed rST and Sphinx in the kernel, so it's plausible that in the
>> future the kernel will pick Hawkmoth.  I agree that we should check with
>> him about his plans.
>>
>>> QEMU should pick a tool which is well established / widely used & thus
>>> stands a good chance of being maintained for the long term, as we don't
>>> want to end up relying on abandonware in 5 years time.  The kernel-doc
>>> project is not widely used, but its main user is significant enough that
>>> it isn't likely to die through lack of maintainers.
>>
>> A couple years ago I didn't have problems modifying kerneldoc for QEMU's
>> syntax, it was a 10 lines patch.  Unfortunately I cannot find it anymore.
> 
> Do you mean the following patch?

You're awesome! :)

Paolo

> ----- Forwarded message from Paolo Bonzini <pbonzini@redhat.com> -----
> 
> Date: Thu, 5 Jan 2017 17:47:30 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: Re: [Qemu-devel] Sphinx for QEMU docs? (and a doc-comment format question)
> 
> 
> 
> On 07/11/2016 16:03, Peter Maydell wrote:
>> 2) some of the doc-comment format differences are irritating:
>>    . "function - short description" not "function: short description"
>>    . "&struct.fieldname" not ".@fieldname"
>>    . "&typename" not "#typename"
>> 3) the most awkward part of kernel-doc syntax is that it bakes
>>    in the kernel's style choice of always using "struct foo"
>>    for types -- I don't think there's any way to document
>>    'MemoryRegion' and 'AddressSpace' without the 'struct'
>>    coming out in the documentation output.
>>
>> We could fix (2) by loosening the kernel-doc script's
>> parsing if we were happy to carry around a forked version
>> of it. Fixing (3) requires more serious surgery on kernel-doc
>> I suspect.
> 
> I've sent some changes to kernel-doc to simplify the implementation of
> these changes (http://www.spinics.net/lists/linux-doc/msg42354.html) and
> they were accepted.  So with 4.10 + those patches, the local changes to
> kernel-doc for QEMU would be limited to the following:
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 4c9ada36fe6b..c43ac038398d 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -215,18 +215,18 @@ my $type_func = '(\w+)\(\)';
>  my $type_param = '\@(\w+(\.\.\.)?)';
>  my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
>  my $type_env = '(\$\w+)';
> -my $type_enum = '\&(enum\s*([_\w]+))';
> -my $type_struct = '\&(struct\s*([_\w]+))';
> -my $type_typedef = '\&(typedef\s*([_\w]+))';
> -my $type_union = '\&(union\s*([_\w]+))';
> -my $type_member = '\&([_\w]+)(\.|->)([_\w]+)';
> -my $type_fallback = '\&([_\w]+)';
> -my $type_enum_xml = '\&amp;(enum\s*([_\w]+))';
> -my $type_struct_xml = '\&amp;(struct\s*([_\w]+))';
> -my $type_typedef_xml = '\&amp;(typedef\s*([_\w]+))';
> -my $type_union_xml = '\&amp;(union\s*([_\w]+))';
> -my $type_member_xml = '\&amp;([_\w]+)(\.|-\&gt;)([_\w]+)';
> -my $type_fallback_xml = '\&amp([_\w]+)';
> +my $type_enum = '#(enum\s*([_\w]+))';
> +my $type_struct = '#(struct\s*([_\w]+))';
> +my $type_typedef = '#(([A-Z][_\w]*))';
> +my $type_union = '#(union\s*([_\w]+))';
> +my $type_member = '#([_\w]+)(\.|->)([_\w]+)';
> +my $type_fallback = '(?!)';    # this never matches
> +my $type_enum_xml = $type_enum;
> +my $type_struct_xml = $type_struct;
> +my $type_typedef_xml = $type_typedef;
> +my $type_union_xml = $type_union;
> +my $type_member_xml = $type_member;
> +my $type_fallback_xml = $type_fallback;
>  my $type_member_func = $type_member . '\(\)';
>  
>  # Output conversion substitutions.
> @@ -2143,6 +2143,14 @@ sub output_blockhead {
>  sub dump_declaration($$) {
>      no strict 'refs';
>      my ($prototype, $file) = @_;
> +    if ($decl_type eq 'type name') {
> +	if ($prototype =~ /^(enum|struct|union)\s+/) {
> +	    $decl_type = $1;
> +        } else {
> +	    return;
> +	}
> +    }
> +
>      my $func = "dump_" . $decl_type;
>      &$func(@_);
>  }
> @@ -2893,7 +2901,7 @@ sub process_file($) {
>  	    }
>  	    elsif (/$doc_decl/o) {
>  		$identifier = $1;
> -		if (/\s*([\w\s]+?)\s*-/) {
> +		if (/\s*([\w\s]+?)(\s*-|:)/) {
>  		    $identifier = $1;
>  		}
>  
> @@ -2903,7 +2911,7 @@ sub process_file($) {
>  		$contents = "";
>  		$section = $section_default;
>  		$new_start_line = $. + 1;
> -		if (/-(.*)/) {
> +		if (/[-:](.*)/) {
>  		    # strip leading/trailing/multiple spaces
>  		    $descr= $1;
>  		    $descr =~ s/^\s*//;
> @@ -2921,7 +2929,9 @@ sub process_file($) {
>  			++$warnings;
>  		}
>  
> -		if ($identifier =~ m/^struct/) {
> +		if ($identifier =~ m/^[A-Z]/) {
> +		    $decl_type = 'type name';
> +	        } elsif ($identifier =~ m/^struct/) {
>  		    $decl_type = 'struct';
>  		} elsif ($identifier =~ m/^union/) {
>  		    $decl_type = 'union';
> 
> which should be maintainable as a fork of Linux's kernel-doc.
> 
> I also worked a bit on support for Texinfo manuals in Sphinx.  My
> current attempt is at http://people.redhat.com/pbonzini/qemu-test-doc/_build/.
> Because this uses a Texinfo->Docbook->Sphinx pipeline, I also tried some
> tools with native Docbook support (Publican), but despite Sphinx's quirks
> the output was less usable, and the tools were slower and harder to use.
> 
> http://wiki.qemu-project.org/Features/Documentation is another place to
> brainstorm ideas on this.


