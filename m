Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A949C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BA2206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MshQoSN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BA2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUFV-0007Bx-FZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTyr-0000cF-CU
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXTyp-0006Ly-5K
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 14:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603824358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMYtw9EfzPQcyq91jyq2Q4b0W5W99gDgtXs3WKYpIm8=;
 b=MshQoSN/OaZlT0JFdxTSovDtmcsZAZ+6zEP5DEfsrwTFTQtiLgK6Nqg5+UMxhxu0hnp+T3
 +VdVfZcJrAHqU8sFO7bN3uBODNPr3jDpF2n1wnCXjZZf9+j4p3coNx1eI3EuEwoZJs6PSQ
 b667ZQUnP4NwAs4ybmMGb8hFwLyilJ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-V5ROU8HaNM6SwX-uOJP2pg-1; Tue, 27 Oct 2020 14:45:53 -0400
X-MC-Unique: V5ROU8HaNM6SwX-uOJP2pg-1
Received: by mail-wr1-f69.google.com with SMTP id i6so1083424wrx.11
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 11:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IMYtw9EfzPQcyq91jyq2Q4b0W5W99gDgtXs3WKYpIm8=;
 b=b1kurqUP/pTwo27TzxowkYVR6/VZ71SmAOrzxxdRsCxtQK27emoCS3Y9/SmHv81qb8
 92GsGf1B2BUqyAUbDiYW2jT1RnWwaGY4YTv0cJSAA7kr3frRFi0vYTH/292aFxRny71b
 WB5NhQ8ljc/4KpdjCD5VZmnmANNFbH22+gtTQhdhkOkhzLLrul5sZX4ICARFbcS6dnKD
 rZSarysSBltWY7HRuGHQZ8X/619zMmcE/f8FFVp+1Zz/5t79bL55uqDH/a3KsrAvDYiW
 aJ4GxUwgtMqcdyA8l/JIf1v4AETB7VFV+EzGSYucfJ/72sad1+OJsGGDjfSSUet14Bch
 bvCA==
X-Gm-Message-State: AOAM531fn7gXCKbUNFyHYu6B25oKZkcjD+gy8fMHbQrqHhT18FxqBR5A
 GnOGDueyDsaHkzDjjUqEJ1WxUjl90D8l0JztkHRMkxgwhPuvHAIoJqS/Br+tOBv5pql9ZTRKtm+
 Y9ts22yNhrxy8DFA=
X-Received: by 2002:adf:ef02:: with SMTP id e2mr4201730wro.381.1603824352305; 
 Tue, 27 Oct 2020 11:45:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsVF2AmeF449Un8DK5wiJ7fAecvduhyUwX6uGHvDc0GOJe2/2dxQ6aEgD/LPHWw8adfFQprA==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr4201701wro.381.1603824351894; 
 Tue, 27 Oct 2020 11:45:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id f17sm2870200wme.22.2020.10.27.11.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 11:45:51 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027132015.621733-1-berrange@redhat.com>
 <20201027132015.621733-7-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [qemu-web PATCH v2 06/16] Rework display of screenshots to use a
 carousel slider
Message-ID: <76f75b93-ef9c-d957-0045-ce2b0c2fa966@redhat.com>
Date: Tue, 27 Oct 2020 19:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027132015.621733-7-berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/20 14:20, Daniel P. Berrangé wrote:
> We have a number of screenshots to display, with three fitted across the
> width of the screen. The screenshots dominate the usage of screen real
> estate on the front page, with other relevant information off the bottom
> of the page.
> 
> As a step towards increasing the information density of the home screen
> replace the horizontally presented screenshots with a rotating carousel
> of images.

Looks good, but the left and right columns are a bit unbalanced.
Since you are at it, perhaps you could organize the part below the red
strip a bit like the Dolphin home page (https://dolphin-emu.org/):


    ----------------------------------------------------------
                             QEMU
          Generic, open source emulator and virtualizer
    ----------------------------------------------------------


         Latest release:                    CAROUSEL
         ....                                . . .



         Contribute              Recent posts
         .....                   ....

         Advent calendar
         Blog planet
         KVM
         Libguestfs
         Libvirt
         Xen
    ---------------------------------------------------------


Also, possibly include the excerpt of the first post ({{post.excerpt}}).

Thanks!

Paolo

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  _data/screenshots.yml     | 14 ++++++++++++--
>  _includes/screenshot.html |  8 ++++++--
>  assets/css/style.css      | 10 +++++++---
>  index.html                | 36 ++++++++++++++++--------------------
>  4 files changed, 41 insertions(+), 27 deletions(-)
> 
> diff --git a/_data/screenshots.yml b/_data/screenshots.yml
> index 3b8b6a5..2811244 100644
> --- a/_data/screenshots.yml
> +++ b/_data/screenshots.yml
> @@ -3,18 +3,28 @@
>    author: "Screenshot by [User:Nurnware](https://commons.wikimedia.org/wiki/User:Nurnware)"
>    description: "QEMU running the ReactOS operating system on Linux."
>    description_md: "QEMU running the [ReactOS](http://www.reactos.org) operating system on Linux."
> -- file: qemu-arm.png
> -  description: "QEMU running a 32-bit ARM binary on a 64-bit Linux system."
> +  heading: Full-system emulation
> +  blurb: Run operating systems for any machine, on any supported architecture
>  - file: qemu-advent-calendar-osv-redis.png
>    source: http://www.qemu-advent-calendar.org/#day-11
>    author: "Courtesy of Dor Laor"
>    description: "The dashboard of the OSv operating system, running in the background as a QEMU/KVM process."
>    description_md: "The dashboard of the [OSv](http://osv.io) operating system, running in the background as a QEMU/KVM process."
> +  heading: Virtualization
> +  blurb: Run KVM and Xen virtual machines with near native performance
> +- file: qemu-arm.png
> +  description: "QEMU running a 32-bit ARM binary on a 64-bit Linux system."
> +  heading: User-mode emulation
> +  blurb: Run programs for another Linux/BSD target, on any supported architecture
>  - file: qemu-advent-calendar-s390-moon-buggy.png
>    source: http://www.qemu-advent-calendar.org/#day-22
>    author: "Courtesy of Alexander Graf"
>    description: "QEMU emulating an ASCII art game for the System z (s390) mainframe."
> +  heading: Full-system emulation
> +  blurb: Run operating systems for non-native architectures
>  - file: qemu-advent-calendar-second-reality.png
>    source: http://www.qemu-advent-calendar.org/#day-13
>    author: "Courtesy of Paolo Bonzini"
>    description: "QEMU running Second Reality, a well-known PC demo from 1993, inside the FreeDOS operating system."
> +  heading: Full-system emulation
> +  blurb: Run demos written for classic / obsolete operating systems
> diff --git a/_includes/screenshot.html b/_includes/screenshot.html
> index 70b0d11..fb79e5d 100644
> --- a/_includes/screenshot.html
> +++ b/_includes/screenshot.html
> @@ -1,9 +1,13 @@
>  {% for screenshot in site.data.screenshots offset: {{include.offset}} limit: {{include.limit}} %}
> -<a href="screenshots/{{screenshot.file}}" class="colorbox"
> +<section>
> +  {% if screenshot.heading %}<h3>{{ screenshot.heading }}</h3>{% endif %}
> +  <div class="pennant"><a href="screenshots/{{screenshot.file}}" class="colorbox"
>     title="{{screenshot.description}}"
>     data-title="{% if screenshot.description_md %}{{screenshot.description_md | markdownify | remove: '<p>' | remove: '</p>' | strip_newlines | escape}}{%
>     else %}{{screenshot.description}}{%endif %}{%
>     if screenshot.author %} {{screenshot.author | markdownify | remove: '<p>' | remove: '</p>' | strip_newlines | escape}} {% endif %}{%
>     if screenshot.source %} (&lt;a href=&quot;{{screenshot.source}}&quot;&gt;Source&lt;/a&gt;){%endif %}"><img
> -   src="screenshots/{{screenshot.file}}" alt="Screenshot: {{screenshot.description}}"/></a>
> +   src="screenshots/{{screenshot.file}}" alt="Screenshot: {{screenshot.description}}"/></a></div>
> +  {% if screenshot.blurb %}<p>{{ screenshot.blurb }}</p>{% endif %}
> +</section>
>  {% endfor %}
> diff --git a/assets/css/style.css b/assets/css/style.css
> index e09b383..855217b 100644
> --- a/assets/css/style.css
> +++ b/assets/css/style.css
> @@ -557,13 +557,14 @@
>  	#featured header
>  	{
>  		border-bottom: 1px solid #333333;
> +		margin-bottom: 0.5em;
>  	}
>  	#featured h2
>  	{
>  		margin-bottom: 0em;
>  	}
>  
> -	#featured h3
> +	#featured .screenshots h3
>  	{
>  		padding: 1.5em 0em;
>  		font-size: 1.6em;
> @@ -573,12 +574,15 @@
>  		margin: 0em 0em 1em 0em;
>  	}
>  
> -	#featured .pennant
> +	#featured .screenshots .pennant
>  	{
>  		font-size: 4em;
> +		width: 40%;
> +		margin-left: auto;
> +		margin-right: auto;
>  	}
>  
> -	#featured .pennant img
> +	#featured .screenshots .pennant img
>  	{
>  		width: 100%;
>  		object-fit: contain;
> diff --git a/index.html b/index.html
> index e52868d..48304c8 100644
> --- a/index.html
> +++ b/index.html
> @@ -2,6 +2,7 @@
>  title: QEMU
>  layout: home
>  colorbox: True
> +bxslider: True
>  ---
>  {% include relative_root.html %}
>  	<!-- Header -->
> @@ -19,25 +20,9 @@ colorbox: True
>  			<h2>What is QEMU?</h2>
>  			<p>QEMU is a generic and open source machine emulator and virtualizer.</p>
>  		</header>
> -		<div class="row">
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=0 limit=1 %}</div>
> -				<h3>Full-system<br class="only-desktop"> emulation</h3>
> -				<p>Run operating systems for any machine, on any supported architecture</p>
> -			</section>
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=1 limit=1 %}</div>
> -				<h3>User-mode<br class="only-desktop"> emulation</h3>
> -				<p>Run programs for another Linux/BSD target, on any supported architecture</p>
> -			</section>
> -			<section class="4u">
> -				<div class="pennant">{% include screenshot.html offset=2 limit=1 %}</div>
> -				<h3>Virtualization</h3>
> -				<p>Run KVM and Xen virtual machines with near native performance</p>
> -			</section>
> -			<section style="display: none;">
> -			{% include screenshot.html offset=3 limit=10 %}
> -			</section>
> +		<div class="row slider screenshots">
> +			{% include screenshot.html %}
> +		</div>
>  
>  <script src="{{ relative_root }}/assets/js/object-fit.js"></script>
>  <script>
> @@ -59,9 +44,20 @@ $(window).on("load resize", function() {
>  $('.colorbox').on("click.random-namespace", function() {
>      return window.hasColorBox;
>  })
> +
> +$(document).ready(function(){
> +    $('.slider').bxSlider({
> +        auto: true,
> +        autoHover: true,
> +        mode: "fade",
> +        infiniteLoop: true,
> +        controls: false,
> +        speed: 500,
> +        pause: 5000,
> +    });
> +});
>  </script>
>  
> -		</div>
>  		<hr>
>  		<p>QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>.</p>
>  	</div>
> 


