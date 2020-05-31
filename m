Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B1C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:28:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA3E206F1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 11:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGDOH//H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfM8p-0001VK-LD
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 07:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfM7s-000148-Fx
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:27:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfM7q-0001pm-Tp
 for qemu-devel@nongnu.org; Sun, 31 May 2020 07:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590924453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+rhvB2BO8YWp/irXNbbOhgmq5q6FB59Dl2dRnBb8q34=;
 b=WGDOH//H8vDAqMrwBxkMc5R84TSdA0i9hhah0hQoaeIlSWofs+ISKqImWKRvC8rKxSniY9
 YZLiXlXy0Tm8f4MfDqHicXXZI8HUITMlnNZRw7OofNlnsnYgSMMht6iS/8RqF2sII+PTpD
 BEHBS0XqRBGjNmx6FT1tPpxfIBFXuxI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-d347J8qqM1WL7TuN3ds5Hw-1; Sun, 31 May 2020 07:27:31 -0400
X-MC-Unique: d347J8qqM1WL7TuN3ds5Hw-1
Received: by mail-wr1-f69.google.com with SMTP id w16so3349655wru.18
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 04:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=+rhvB2BO8YWp/irXNbbOhgmq5q6FB59Dl2dRnBb8q34=;
 b=YGMWOEVN9ds1By0ZBSE27yV+LCBQ8azlYgPVcIRBBAbueAeM4ugWR4bNnCTWh+ZltN
 QNfrLMT8pSL4txbP0kKpNXKR8NWSi3MQ2wXmsIjRwuSlTbuK96iz1PEsGOFZ81Mm7DpX
 e75pU4eyoTHEwhpGqfUg8RSo0wt9QQWuALWgynBf+2wSU620IkExq2RgXJ1+5ijpWrPJ
 X6LoecALPMfi18YILK9hkjI2sIKJlRIG/U4HFg/sWCEVxJjv44BfZirlMyrYEtrOA8/L
 gXZJE232YrP34/yMAWlTmsyZRNt/vO1E/qfqGCEdK1DVJeyRYuwqpplwps9gbx/Haif5
 WCiA==
X-Gm-Message-State: AOAM531A5VcEXI5VJJGe7wvRZWEmGHLSFL3C3hmpAqzvzTFdA0WWDsUj
 zMJQgBTIllI/h4oltiDS3a05y3TLSM/46UTIGqzyNkzG5YoUrelbn+O22BYjdsvgs8hhHrVz4fZ
 JUh3ZiG4j2yWze7I=
X-Received: by 2002:adf:dec5:: with SMTP id i5mr14078556wrn.16.1590924450198; 
 Sun, 31 May 2020 04:27:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpZJ29jrqcNnaufY8CaPfx06LQDqfZ9Ua8Uptm1K9676CAkPrIVEPuXFN5IpeiTTpJmvVK2A==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr14078542wrn.16.1590924449973; 
 Sun, 31 May 2020 04:27:29 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 40sm17545481wrc.15.2020.05.31.04.27.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 04:27:29 -0700 (PDT)
Subject: Re: [PATCH v8 12/12] tests/vm: Add workaround to consume console
To: Robert Foley <robert.foley@linaro.org>, qemu-devel@nongnu.org
References: <20200529203458.1038-1-robert.foley@linaro.org>
 <20200529203458.1038-13-robert.foley@linaro.org>
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
Message-ID: <235ec2d4-f8ee-5192-9da5-4e29b2599525@redhat.com>
Date: Sun, 31 May 2020 13:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529203458.1038-13-robert.foley@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 05:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> This adds support to basevm.py so that we always
> drain the console chars.  This makes use of
> support added in an earlier commit that allows
> QEMUMachine to use the ConsoleSocket.
> 
> This is a workaround we found was needed since
> there is a known issue where QEMU will hang waiting
> for console characters to be consumed.
> 
> We also added the option of logging the console to a file.
> LOG_CONSOLE=1 will now log the output to a file.
> 
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/vm/Makefile.include |  4 ++++
>  tests/vm/basevm.py        | 17 +++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 8cccfaf95d..ad35c6e7a1 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -49,6 +49,7 @@ endif
>  	@echo '    EXTRA_CONFIGURE_OPTS="..."'
>  	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
>  	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
> +	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
>  	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
>  	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
>  	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
> @@ -75,6 +76,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
>  		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
> +		$(if $(LOG_CONSOLE),--log-console) \
>  		--image "$@" \
>  		--force \
>  		--build-image $@, \
> @@ -91,6 +93,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(V),--verbose) \
>  		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
> +		$(if $(LOG_CONSOLE),--log-console) \
>  		--image "$<" \
>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
>  		--snapshot \
> @@ -114,6 +117,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>  		$(if $(V)$(DEBUG), --debug) \
>  		$(if $(QEMU_LOCAL),--build-path $(BUILD_DIR)) \
>  		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
> +		$(if $(LOG_CONSOLE),--log-console) \
>  		--image "$<" \
>  		--interactive \
>  		false, \
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index b9d828423b..64dbe64326 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -117,6 +117,11 @@ class BaseVM(object):
>               "w").write(self._config['ssh_pub_key'])
>  
>          self.debug = args.debug
> +        self._console_log_path = None
> +        if args.log_console:
> +                self._console_log_path = \
> +                         os.path.join(os.path.expanduser("~/.cache/qemu-vm"),
> +                                      "{}.install.log".format(self.name))
>          self._stderr = sys.stderr
>          self._devnull = open(os.devnull, "w")
>          if self.debug:
> @@ -271,7 +276,9 @@ class BaseVM(object):
>          args += self._data_args + extra_args + self._config['extra_args']
>          logging.debug("QEMU args: %s", " ".join(args))
>          qemu_path = get_qemu_path(self.arch, self._build_path)
> -        guest = QEMUMachine(binary=qemu_path, args=args)
> +        guest = QEMUMachine(binary=qemu_path, args=args,
> +                            console_log=self._console_log_path,
> +                            drain_console=True)

Are you sure you need to set drain_console here? Isn't it implied by
self._console_log_path?

>          guest.set_machine(self._config['machine'])
>          guest.set_console()
>          try:
> @@ -285,6 +292,8 @@ class BaseVM(object):
>              raise
>          atexit.register(self.shutdown)
>          self._guest = guest
> +        # Init console so we can start consuming the chars.
> +        self.console_init()
>          usernet_info = guest.qmp("human-monitor-command",
>                                   command_line="info usernet")
>          self.ssh_port = None
> @@ -296,7 +305,9 @@ class BaseVM(object):
>              raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
>                              usernet_info)
>  
> -    def console_init(self, timeout = 120):
> +    def console_init(self, timeout = None):
> +        if timeout == None:
> +            timeout = self.socket_timeout
>          vm = self._guest
>          vm.console_socket.settimeout(timeout)
>          self.console_raw_path = os.path.join(vm._temp_dir,
> @@ -578,6 +589,8 @@ def parse_args(vmcls):
>      parser.add_option("--efi-aarch64",
>                        default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
>                        help="Path to efi image for aarch64 VMs.")
> +    parser.add_option("--log-console", action="store_true",
> +                      help="Log console to file.")
>      parser.disable_interspersed_args()
>      return parser.parse_args()
>  
> 


