Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF14C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193732075F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5FpzLpi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193732075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbz5-0000Ps-B7
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbyL-00080f-9A
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:58:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28842)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbyK-0003y1-9w
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590508711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OQN9ctO8CT9Xzu5QA9ifWkpbwDdfaibo679geK7DbK4=;
 b=M5FpzLpiIZCUL2R/2N8vtUsHoPb+a8j9Drti4aA4Ujzfg3K21zl1ulLyYXFoalquKDemV5
 JfXwf2Lw3w6k57XI/jrOPrDraCqSNevC1bfo9mmtWmfKyIR8Isd8hyXRKySz1sK6QafCRU
 +zx5geTOTQqcfn/yg6uAuNhYgHLR/hU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-0EGWE5yGOKeHyMXDu6-LRw-1; Tue, 26 May 2020 11:58:29 -0400
X-MC-Unique: 0EGWE5yGOKeHyMXDu6-LRw-1
Received: by mail-ed1-f70.google.com with SMTP id bo26so9095822edb.22
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=OQN9ctO8CT9Xzu5QA9ifWkpbwDdfaibo679geK7DbK4=;
 b=pj3ILAPC4J9ACut9EnnJ3eYy8wDeLMpU1aIv+6FcX9+Dg9TL9/3cgBJPMkkBK190Wq
 eMWwlzTXSuJ5E7vngvnLJmcPco/7HrEguPH9UEHMBClccp/1maOymD3UKXbbYog9HPJg
 fd6EqUbq1uuapUsNq1pZ3lzn6g+EJ0cdV+7joas/hDcIBHa8n6ZuYbjSRtCEJJKP+8s6
 qokaMyZYKc1Bzhffp2IJ2AXFEAE+sUtcXULFQyXXgTbPn37YOpZ8jw8pYcRfM/Qz9YlN
 tLrC6oF6T7cpVICCmDhTv6/7Haq4833T361ovlsgAR7Up2XXOePlKj6M4vpIuiuH99jG
 RFGw==
X-Gm-Message-State: AOAM5319NyulImLTAgv+vnBtAwSWsYtf3dz1d0HQakfI8DdSnLa5etzM
 fc8q2ziDNX6tKW/FYZCiWe5kh98LwGiPomA2gvFK24zhTUGCVEHTcIz0cUOrzXznEh5h15b8Bir
 kjWVEm63i9VQ74ZA=
X-Received: by 2002:a17:906:c108:: with SMTP id
 do8mr1869221ejc.134.1590508708280; 
 Tue, 26 May 2020 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+Bxz+LQyLJl5fx5/hiik4mnBJGsAJvXxzv8grdd15PNcVcA7n+6hr/EV3T7/rYQnjRmQEmw==
X-Received: by 2002:a17:906:c108:: with SMTP id
 do8mr1869203ejc.134.1590508707985; 
 Tue, 26 May 2020 08:58:27 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id c27sm253948ejd.19.2020.05.26.08.58.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:58:27 -0700 (PDT)
Subject: Re: [PATCH RFC 05/32] python/qemu/lib: delint; add flake8 config
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-6-jsnow@redhat.com>
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
Message-ID: <ff3b048a-46ce-6551-1eca-d29e16d55a70@redhat.com>
Date: Tue, 26 May 2020 17:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-6-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:
> Mostly, ignore the "no bare except" rule, because flake8 is not
> contextual and cannot determine if we re-raise. Pylint can, though, so
> always prefer pylint for that.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/lib/.flake8    |  2 ++
>  python/qemu/lib/accel.py   |  9 ++++++---
>  python/qemu/lib/machine.py | 13 +++++++++----
>  python/qemu/lib/qmp.py     |  4 ++--
>  4 files changed, 19 insertions(+), 9 deletions(-)
>  create mode 100644 python/qemu/lib/.flake8
> 
> diff --git a/python/qemu/lib/.flake8 b/python/qemu/lib/.flake8
> new file mode 100644
> index 0000000000..45d8146f3f
> --- /dev/null
> +++ b/python/qemu/lib/.flake8
> @@ -0,0 +1,2 @@
> +[flake8]
> +extend-ignore = E722  # Pylint handles this, but smarter.
> \ No newline at end of file
> diff --git a/python/qemu/lib/accel.py b/python/qemu/lib/accel.py
> index 36ae85791e..7fabe62920 100644
> --- a/python/qemu/lib/accel.py
> +++ b/python/qemu/lib/accel.py
> @@ -23,11 +23,12 @@
>  # Mapping host architecture to any additional architectures it can
>  # support which often includes its 32 bit cousin.
>  ADDITIONAL_ARCHES = {
> -    "x86_64" : "i386",
> -    "aarch64" : "armhf",
> -    "ppc64le" : "ppc64",
> +    "x86_64": "i386",
> +    "aarch64": "armhf",
> +    "ppc64le": "ppc64",
>  }
>  
> +
>  def list_accel(qemu_bin):
>      """
>      List accelerators enabled in the QEMU binary.
> @@ -47,6 +48,7 @@ def list_accel(qemu_bin):
>      # Skip the first line which is the header.
>      return [acc.strip() for acc in out.splitlines()[1:]]
>  
> +
>  def kvm_available(target_arch=None, qemu_bin=None):
>      """
>      Check if KVM is available using the following heuristic:
> @@ -69,6 +71,7 @@ def kvm_available(target_arch=None, qemu_bin=None):
>          return False
>      return True
>  
> +
>  def tcg_available(qemu_bin):
>      """
>      Check if TCG is available.
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index c79fc8fb89..4b260fa2cb 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -29,6 +29,7 @@
>  
>  LOG = logging.getLogger(__name__)
>  
> +
>  class QEMUMachineError(Exception):
>      """
>      Exception called when an error in QEMUMachine happens.
> @@ -62,7 +63,8 @@ class QEMUMachine:
>      """
>      A QEMU VM
>  
> -    Use this object as a context manager to ensure the QEMU process terminates::
> +    Use this object as a context manager to ensure
> +    the QEMU process terminates::
>  
>          with VM(binary) as vm:
>              ...
> @@ -188,8 +190,10 @@ def send_fd_scm(self, fd=None, file_path=None):
>              fd_param.append(str(fd))
>  
>          devnull = open(os.path.devnull, 'rb')
> -        proc = subprocess.Popen(fd_param, stdin=devnull, stdout=subprocess.PIPE,
> -                                stderr=subprocess.STDOUT, close_fds=False)
> +        proc = subprocess.Popen(
> +            fd_param, stdin=devnull, stdout=subprocess.PIPE,
> +            stderr=subprocess.STDOUT, close_fds=False
> +        )
>          output = proc.communicate()[0]
>          if output:
>              LOG.debug(output)
> @@ -491,7 +495,8 @@ def event_wait(self, name, timeout=60.0, match=None):
>  
>      def events_wait(self, events, timeout=60.0):
>          """
> -        events_wait waits for and returns a named event from QMP with a timeout.
> +        events_wait waits for and returns a named event
> +        from QMP with a timeout.
>  
>          events: a sequence of (name, match_criteria) tuples.
>                  The match criteria are optional and may be None.
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index d6c9b2f4b1..6ae7693965 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -168,8 +168,8 @@ def accept(self, timeout=15.0):
>  
>          @param timeout: timeout in seconds (nonnegative float number, or
>                          None). The value passed will set the behavior of the
> -                        underneath QMP socket as described in [1]. Default value
> -                        is set to 15.0.
> +                        underneath QMP socket as described in [1].
> +                        Default value is set to 15.0.
>          @return QMP greeting dict
>          @raise OSError on socket connection errors
>          @raise QMPConnectError if the greeting is not received
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


