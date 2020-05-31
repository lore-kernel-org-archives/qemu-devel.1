Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA44C20776
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKiIP/RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA44C20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfLFO-0002HW-Ub
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 06:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLEe-0001Ie-1N
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:30:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfLEc-0007e6-Bm
 for qemu-devel@nongnu.org; Sun, 31 May 2020 06:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590921029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=74mP/xfVlJG5y1zKEhL0DHwFugIE/7NYLepYT8EqfhM=;
 b=gKiIP/RBXNDBgHO98TiKDchMylylI9h2xlff2Bdnm5PcrVsX0ANIzYYYd721ra2OKijGDy
 2cLLPqXzR/DfRbdUa6YZ8KnmJN/LcIHDn3km34FadMeFD/X62iFXmSQHXSRsj0NP1U/7bf
 4aaR8MXSV8lqVzO0HRNuHi6rGxgK6qk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-9Q404w0wOkydRC1U-3T7IQ-1; Sun, 31 May 2020 06:30:27 -0400
X-MC-Unique: 9Q404w0wOkydRC1U-3T7IQ-1
Received: by mail-wr1-f70.google.com with SMTP id e7so2838482wrp.14
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 03:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=74mP/xfVlJG5y1zKEhL0DHwFugIE/7NYLepYT8EqfhM=;
 b=DHF7Efai5zCxgzJAEq1+sD6/7CEwWpazX3DKuuJsNFp3nYdC9byD2BHq298Ska8BnP
 V7d6K54fyUNTEqNaiZOFjBlMC1OdIFPRiIE3EhaLDXKPLpdJ8fpGYZUb/R9w/uYK3fIh
 e9uIea+fxCEpEHt8m8UZyBBNHFsAzYVhYZA0c8l/ZOK1XwLxhtb2Pe40CxTZJ+CewZET
 3z/CRJbsrZEXZMZa2ijBf+HrjrHtf2ecx8UlBJgms6/FOErH6u9ypfReeikgzd2hZ5Kj
 +W9sHs4RQ9YwQGOWV9ikaO9BU/+DYCG6N42lyrBPGyhocqqEPtzXxtR0qn3ib24j1GiC
 QXWA==
X-Gm-Message-State: AOAM533JES9cbCjUDeGMoGbEVyB0At2K3bVK5qlqaH6hSc4Jcqh0DYwq
 Dyp9GKL6Cqrm3LCmVYiLivmruc19a7/Dn0U5U511C4Nz7P8ZN3Jl7OxGhP1tQZw2rMRZj1O2DPy
 iRm0jYlD6+OnvCWo=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr17563726wmg.21.1590921026176; 
 Sun, 31 May 2020 03:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAhKDoRq/wxypeRD0TQpTuF/9XSSKmi5JWQwSSJKZUPJdIyWe5GalCnN+esJ52N3nXcbOdwQ==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr17563711wmg.21.1590921025900; 
 Sun, 31 May 2020 03:30:25 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id b187sm7156397wmd.26.2020.05.31.03.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 03:30:25 -0700 (PDT)
Subject: Re: [PATCH v8 05/12] tests/vm: Add ability to select QEMU from
 current build.
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-6-robert.foley@linaro.org>
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
Message-ID: <1076915e-b436-ae67-f756-d6a83637a932@redhat.com>
Date: Sun, 31 May 2020 12:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-6-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:57:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 10:34 PM, Robert Foley wrote:
> Added a new special variable QEMU_LOCAL=1, which
> will indicate to take the QEMU binary from the current
> build.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/Makefile.include |  4 ++++
>  tests/vm/basevm.py        | 23 ++++++++++++++++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index e22c391a2a..f6c3892bb2 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -41,6 +41,7 @@ endif
>  	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
>  	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
>  	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
> +	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
>  	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
>  	@echo "    QEMU_IMG=/path/to/qemu-img	 - Change path to qemu-img tool"
>  ifeq ($(PYTHON_YAML),yes)
> @@ -63,6 +64,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  		$(PYTHON) $< \
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
> +		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		--image "$@" \
>  		--force \
>  		--build-image $@, \
> @@ -77,6 +79,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(DEBUG), --interactive) \
>  		$(if $(J),--jobs $(J)) \
>  		$(if $(V),--verbose) \
> +		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		--image "$<" \
>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
>  		--snapshot \
> @@ -98,6 +101,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>  		$(if $(J),--jobs $(J)) \
>  		$(if $(V)$(DEBUG), --debug) \
> +		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		--image "$<" \
>  		--interactive \
>  		false, \
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 7d23ae279b..75a7ac2bd3 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -91,6 +91,7 @@ class BaseVM(object):
>      def __init__(self, args, config=None):
>          self._guest = None
>          self._genisoimage = args.genisoimage
> +        self._build_path = args.build_path
>          # Allow input config to override defaults.
>          self._config = DEFAULT_CONFIG.copy()
>          if config != None:
> @@ -275,15 +276,15 @@ class BaseVM(object):
>          args = self._args + boot_params.split(' ')
>          args += self._data_args + extra_args + self._config['extra_args']
>          logging.debug("QEMU args: %s", " ".join(args))
> -        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
> -        guest = QEMUMachine(binary=qemu_bin, args=args)
> +        qemu_path = get_qemu_path(self.arch, self._build_path)
> +        guest = QEMUMachine(binary=qemu_path, args=args)
>          guest.set_machine(self._config['machine'])
>          guest.set_console()
>          try:
>              guest.launch()
>          except:
>              logging.error("Failed to launch QEMU, command line:")
> -            logging.error(" ".join([qemu_bin] + args))
> +            logging.error(" ".join([qemu_path] + args))
>              logging.error("Log:")
>              logging.error(guest.get_log())
>              logging.error("QEMU version >= 2.10 is required")
> @@ -482,6 +483,19 @@ class BaseVM(object):
>                                stderr=self._stdout)
>          return os.path.join(cidir, "cloud-init.iso")
>  
> +def get_qemu_path(arch, build_path=None):
> +    """Fetch the path to the qemu binary."""
> +    # If QEMU environment variable set, it takes precedence
> +    if "QEMU" in os.environ:
> +        qemu_path = os.environ["QEMU"]
> +    elif build_path:
> +        qemu_path = os.path.join(build_path, arch + "-softmmu")
> +        qemu_path = os.path.join(qemu_path, "qemu-system-" + arch)
> +    else:
> +        # Default is to use system path for qemu.
> +        qemu_path = "qemu-system-" + arch
> +    return qemu_path
> +
>  def parse_config(config, args):
>      """ Parse yaml config and populate our config structure.
>          The yaml config allows the user to override the
> @@ -556,6 +570,9 @@ def parse_args(vmcls):
>      parser.add_option("--config", "-c", default=None,
>                        help="Provide config yaml for configuration. "\
>                             "See config_example.yaml for example.")
> +    parser.add_option("--build-path", default=None,
> +                      help="Path of build directory, "\
> +                           "for using build tree QEMU binary. ")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


