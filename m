Received: from eggs.gnu.org ([2001:4830:134:3::10]:43593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQE38-0000dx-Fi
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQE35-0001xP-CE
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:06 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fQE35-0001wx-1G
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:39:03 -0400
References: <20180605135404.16301-1-laurent@vivier.eu>
	<CAFEAcA95tCKv0sV9hYhn1tiv11wPypEctEbbbO_xqV2f6JRV_Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ee8692d5-231c-5ce2-fc15-173d9742e143@vivier.eu>
Date: Tue, 5 Jun 2018 17:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA95tCKv0sV9hYhn1tiv11wPypEctEbbbO_xqV2f6JRV_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: disable qemu-bridge-helper and
 socket_scm_helper build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Le 05/06/2018 à 16:00, Peter Maydell a écrit :
> On 5 June 2018 at 14:54, Laurent Vivier <laurent@vivier.eu> wrote:
>> linux-user targets don't need them, and if we ask to build statically
>> linked binaries some static binaries they need are not available.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  Makefile               | 2 ++
>>  tests/Makefile.include | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 6d588d1f71..5f198ee4bb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -351,7 +351,9 @@ $(call set-vpath, $(SRC_PATH))
>>
>>  LIBS+=-lz $(LIBS_TOOLS)
>>
>> +ifeq ($(CONFIG_SOFTMMU),y)
>>  HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
>> +endif
> 
> HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =
> qemu-bridge-helper$(EXESUF)
> 

I can try that.

> 
>>  ifdef BUILD_DOCS
>>  DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 86f90c0cb0..adaa5274c8 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -923,7 +923,9 @@ check-report.html: check-report.xml
>>
>>  # Other tests
>>
>> +ifeq ($(CONFIG_SOFTMMU),y)
>>  QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
>> +endif
> 
> Do we also need to do something to ensure that the tests that
> use this helper don't run, or does that happen automatically?

I don't think iotests can run if no machine is configured.

qemu-iotests needs *-softmmu targets, see in tests/qemu-iotests/check

If I tried a "make check-block" with --disable-system it fails with

.../tests/qemu-iotests-quick.sh
check: qemu not found

Thanks,
Laurent
