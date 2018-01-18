Received: from eggs.gnu.org ([2001:4830:134:3::10]:38952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec7mQ-0002gg-JV
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ec7mL-0007F7-1t
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:50:46 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:46024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ec7mK-0007Em-Rs
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:50:40 -0500
Received: by mail-oi0-x22f.google.com with SMTP id j129so15349305oib.12
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 02:50:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180118114330.53ad7ce7@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
	<CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
	<20180118114330.53ad7ce7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jan 2018 10:50:19 +0000
Message-ID: <CAFEAcA-My_vDd=_7g907MpO2WmVHOHKxsw2-E-vQwn=_SZadRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 18 January 2018 at 10:43, Igor Mammedov <imammedo@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> That usage must want a different name, though, surely?
>> For Arm the default CPU for linux-user is 'any' but that
>> is usermode only and won't work for system emulation so
>> null-machine.c will need to pick something else.

> not really in general as boards set their own default types
> and secondly it applies only to null-machine.
> Though in both cases it work the same just fine because
> current API works like this (system emulation)
>  vl.c:
>         current_machine->cpu_type = machine_class->default_cpu_type;
>         if (cpu_model) {
>             current_machine->cpu_type =
>                 cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model);
>             ...
>         }
>
> which would result for null-machine (patch 20/24) in:
>
>        cpu_parse_cpu_model(TARGET_DEFAULT_CPU_TYPE, cpu_model):
>             oc = cpu_class_by_name(TARGET_DEFAULT_CPU_TYPE, cpu_model):
>                  cc = CPU_CLASS(object_class_by_name(TARGET_DEFAULT_CPU_TYPE))
>                  cc->class_by_name(cpu_model)

In system emulation we don't define the "any" cpu type
at all, so I would expect cpu_class_by_name() to always
return an error here.

thanks
-- PMM
