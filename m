Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75005ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:46:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB2B2089F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZD8faNoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB2B2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzvL-0005Wm-A2
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIy43-0003PE-IY
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIy41-0004nq-Fz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:46:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37705)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIy41-0004mB-5s
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:46:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id p14so12673616wro.4
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iRS0jKn4XTp9gE31Tt+k9J2FK+52AEpP7QjprmAQynI=;
 b=ZD8faNoqIq//C3Kg9KoxgmPHTlciplcAm5orG3vDcw5dsTfe6OGym7x4aEs8j6yJnZ
 XIK+hkiXzwJQbivZZgBaJtkIgqbtpeq0JxoybFmrlow64zgLd/0Q2I99TIcoNqNVAn6B
 IkOxzzrxldLYx/SQJUzKakZXtgbf4qYnyinT/TyGB3zkcWPMR+4+QJft057Uj40rP8g7
 vnNOFBS9ZvYL91dqaoQolk+/7J0DTXvFpSbodDqzzvQMrZOmgOhz2xrpnoGwk+6mMZKv
 XFyQj/1+HXWn1w7vsKsKzAtlhCUFSzY7zCNKfwgjfc2g016FyYwMwXScuBYvXz4t5lOR
 yahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iRS0jKn4XTp9gE31Tt+k9J2FK+52AEpP7QjprmAQynI=;
 b=rnPbR5cw/fnrG0+rQtvWKjB4MuHbx9uWviD6Qkr+falvbFRof9FMVdcfzLRm1S1Ge3
 DgS47Is1m5lpO8bAfrMJjFWBiM8IxXYrlW42NGzzJ2B3bSJVDKfToUJ+RGa2pgdYWs6u
 /i7QfocI+jyozpUnlY2kW+8CXairRraCGz35vZTDKznravouaLer6HLYZoRVY+KZceZE
 dlt/gFDj7ePaF0PnjFAVUpbAbAxedHiK70D2SRqXCSF3AkqCy4wHiCBNWavXdph7iuYI
 IVQjzirCL1tXd3960qZckU/Gdz9sMfjE53iUUzjzAYiQqR8wllIHwvGShqLymz/odbPJ
 BCyA==
X-Gm-Message-State: APjAAAUlB+DbZnUoasWc0lRItTFKTL7oqlGa1xjYR4/XlnWAYL4dkcDt
 CarjibIpz7ekZoIQsZUvXT3lsA==
X-Google-Smtp-Source: APXvYqxoluUnausSdD/Fxwgr7N5fmVM7GcrBd+ZHompyBE8ZY/92qsdZUdzwtBmGbQ0jv2eIaL6wTg==
X-Received: by 2002:a5d:4691:: with SMTP id u17mr13845020wrq.41.1570812407379; 
 Fri, 11 Oct 2019 09:46:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s9sm11394525wme.36.2019.10.11.09.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 09:46:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D03C1FF87;
 Fri, 11 Oct 2019 17:46:45 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-44-alex.bennee@linaro.org>
 <1f317f65-289d-659b-735b-d527908140f8@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v4 43/54] plugin: add API symbols to
 qemu-plugins.symbols
In-reply-to: <1f317f65-289d-659b-735b-d527908140f8@linaro.org>
Date: Fri, 11 Oct 2019 17:46:45 +0100
Message-ID: <87wodbkz62.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: bobby.prani@gmail.com, cota@braap.org, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 7/31/19 9:07 AM, Alex Benn=C3=A9e wrote:
>> +#########################################
>> +# See if --dynamic-list is supported by the linker
>> +
>> +cat > $TMPTXT <<EOF
>> +{
>> +  foo;
>> +};
>> +EOF
>> +
>> +cat > $TMPC <<EOF
>> +#include <stdio.h>
>> +void foo(void);
>> +
>> +void foo(void)
>> +{
>> +  printf("foo\n");
>> +}
>> +
>> +int main(void)
>> +{
>> +  foo();
>> +  return 0;
>> +}
>> +EOF
>> +
>> +ld_dynamic_list=3D"no"
>> +if compile_prog "" "-Wl,--dynamic-list=3D$TMPTXT" ; then
>> +  ld_dynamic_list=3D"yes"
>> +fi
>> +
>> +#########################################
>> +# See if -exported_symbols_list is supported by the linker
>> +
>> +cat > $TMPTXT <<EOF
>> +  _foo
>> +EOF
>> +
>> +ld_exported_symbols_list=3D"no"
>> +if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
>> +  ld_exported_symbols_list=3D"yes"
>> +fi
>> +
>> +if  test "$plugins" =3D "yes" &&
>> +    test "$ld_dynamic_list" =3D "no" &&
>> +    test "$ld_exported_symbols_list" =3D "no" ; then
>> +  error_exit \
>> +      "Plugin support requires specifying a set of symbols that " \
>> +      "are exported to plugins. Unfortunately your linker doesn't " \
>> +      "support the flag (--dynamic-list or -exported_symbols_list) used=
 " \
>> +      "for this purpose."
>> +fi
>> +
>>  ########################################
>>  # See if 16-byte vector operations are supported.
>>  # Even without a vector unit the compiler may expand these.
>> @@ -7318,6 +7371,22 @@ fi
>>  if test "$plugins" =3D "yes" ; then
>>      echo "CONFIG_PLUGIN=3Dy" >> $config_host_mak
>>      LIBS=3D"-ldl $LIBS"
>> +    # Copy the export object list to the build dir
>> +    if test "$ld_dynamic_list" =3D "yes" ; then
>> +	echo "CONFIG_HAS_LD_DYNAMIC_LIST=3Dyes" >> $config_host_mak
>> +	ld_symbols=3Dqemu-plugins-ld.symbols
>> +	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
>> +    elif test "$ld_exported_symbols_list" =3D "yes" ; then
>> +	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=3Dyes" >> $config_host_mak
>> +	ld64_symbols=3Dqemu-plugins-ld64.symbols
>> +	echo "# Automatically generated by configure - do not modify" > $ld64_=
symbols
>> +	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g=
' | \
>> +	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
>> +    else
>> +	error_exit \
>> +	    "If \$plugins=3Dyes, either \$ld_dynamic_list or " \
>> +	    "\$ld_exported_symbols_list should have been set to 'yes'."
>> +    fi
>>  fi
>>
>
> How much of this should be skipped if --enable-static?
> Or perhaps just dependent on --enable-plugins and let
> that switch detect the conflict?

I've gated the ld_dynamic_list checks on if test "$static" =3D "no" so it
errors out quickly if you try and build with --static --enable-plugins.


>
>
> r~


--
Alex Benn=C3=A9e

