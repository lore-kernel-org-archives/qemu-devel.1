Received: from eggs.gnu.org ([209.51.188.92]:56781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qqv-0005Yx-2W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qqu-0003ee-8y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:06:17 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1qqs-0003YY-9y
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:06:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id o17so16926869wrw.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 03:06:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
	<CAFEAcA_t=okvOgHNKHttJS0XNcoFhnhX2MHqY1AA-C+nz6d=jw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e14a37bd-9606-a9f6-4426-4142fa79ded1@redhat.com>
Date: Thu, 7 Mar 2019 12:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_t=okvOgHNKHttJS0XNcoFhnhX2MHqY1AA-C+nz6d=jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 07/03/19 11:48, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 10:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> ---
>> # This would be ui/meson.build:
>>
>> vnc_sources = source_set.source_set()
>> vnc_sources.add([], files(
>>     'vnc.c',
>>     'vnc-auth-vencrypt.c',
>>     'vnc-enc-hextile.c',
>>     'vnc-enc-tight.c',
>>     'vnc-enc-zlib.c',
>>     'vnc-enc-zrle.c',
>>     'vnc-jobs.c',
>>     'vnc-palette.c',
>>     'vnc-ws.c'))
>> vnc_sources.add('CONFIG_VNC_SASL', files(
>>     'vnc-auth-sasl.c'))
> 
> All this foo_sources.add() seems pretty clunky syntax,
> which doesn't seem like a good sign for what is
> pretty much the simplest possible case for the build system.

ui/Makefile.objs is actually one of the most complex cases.  The quotes
and commas are indeed somewhat clunky, but I don't think the above
compares particularly negatively to

    vnc-obj-y = vnc.o
    vnc-obj-y += vnc-auth-vencrypt.o
    vnc-obj-y += vnc-enc-hextile.o
    vnc-obj-y += vnc-enc-tight.o
    vnc-obj-y += vnc-enc-zlib.o
    vnc-obj-y += vnc-enc-zrle.o
    vnc-obj-y += vnc-jobs.o
    vnc-obj-y += vnc-palette.o
    vnc-obj-y += vnc-ws.o
    vnc-obj-$(CONFIG_VNC_SASL) += vnc-auth-sasl.o

The simplest possible case is

    common-obj-$(CONFIG_IPACK) += ipack.o tpci200.o

=>  common_obj.add('CONFIG_IPACK', files('ipack.c', 'tpci200.c'))

or

    qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
    qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
    qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)

=>  executable('qemu-keymap',
               ['qemu-keymap.c', 'ui/input-keymap.c'],
               dependencies: [common_deps, xkbcommon])

(where the latter provides "make install" functionality without having
to touch configure).

Paolo
