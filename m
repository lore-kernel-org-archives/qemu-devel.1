Received: from eggs.gnu.org ([2001:4830:134:3::10]:48941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLYt-0006AA-ON
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLYp-00036t-SS
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:52:31 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLYp-00036i-NP
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:52:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id y89-v6so14254927qtd.10
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 10:52:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601162620.32362-1-mst@redhat.com>
	<CAFEAcA_weoW3XS2dppdc=jwpCSSAaiTxaQDxsBBKdjjA4aY_Rg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fe4cdf31-4e5c-c3c8-936b-91a45eaa77ad@amsat.org>
Date: Fri, 8 Jun 2018 14:52:23 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_weoW3XS2dppdc=jwpCSSAaiTxaQDxsBBKdjjA4aY_Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/31] acpi, vhost, misc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/04/2018 07:28 AM, Peter Maydell wrote:
> On 1 June 2018 at 17:26, Michael S. Tsirkin <mst@redhat.com> wrote:
>> The following changes since commit 63b88968f139b6a77f2f81e6f1eedf70c0170a85:
>>
>>   intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>
>> for you to fetch changes up to 25b1d45a1975fd8624c37b5bf42e8502ccf53460:
>>
>>   vhost-blk: turn on pre-defined RO feature bit (2018-06-01 19:20:38 +0300)
>>
>> ----------------------------------------------------------------
>> acpi, vhost, misc: fixes, features
>>
>> vDPA support, fix to vhost blk RO bit handling, some include path
>> cleanups, NFIT ACPI table.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> ----------------------------------------------------------------
> 
> Applied, thanks.

Not sure this is a problem, but something experienced after rebasing:


#1

/source/qemu/qemu-nbd.c: In function ‘version’:
/source/qemu/qemu-nbd.c:133:6: error: expected ‘)’ before
‘QEMU_FULL_VERSION’
 "%s " QEMU_FULL_VERSION "\n"
      ^~~~~~~~~~~~~~~~~~
      )
/source/qemu/qemu-nbd.c:133:3: error: format ‘%s’ expects a matching
‘char *’ argument [-Werror=format=]
 "%s " QEMU_FULL_VERSION "\n"
  ~^
cc1: all warnings being treated as errors

It took me a while to figure this out, probably because today is Friday.

$ git status --ignored show me I had a "qemu-version.h" generated long
time ago in the source directory.

- I only do out-of-tree builds.

- sometimes I run "make help/docker/vm-test" and friends in the source
directory, and my 'make' is aliased as 'make -jN'.
I doubt those make calls generate this file, as ./configure generates
it, so I probably messed with a ./configure in source dir.

Now, building out-of-tree dirs was finding the old /qemu-version.h
before the generated one in current dir.

I was not noticing it due to the /qemu-version.h entry in /.gitignore .


#2

  CC      vl.o
/source/qemu/vl.c: In function ‘main’:
/source/qemu/vl.c:3052:18: error: ‘QEMU_OPTION_blockdev’ undeclared
(first use in this function); did you mean ‘QEMU_OPTION_clock’?
             case QEMU_OPTION_blockdev:
                  ^~~~~~~~~~~~~~~~~~~~
                  QEMU_OPTION_clock
/source/qemu/vl.c:3052:18: note: each undeclared identifier is reported
only once for each function it appears in
/source/qemu/vl.c:3171:18: error: ‘QEMU_OPTION_nic’ undeclared (first
use in this function); did you mean ‘QEMU_OPTION_rtc’?
             case QEMU_OPTION_nic:
                  ^~~~~~~~~~~~~~~
                  QEMU_OPTION_rtc
/source/qemu/vl.c:3574:18: error: ‘QEMU_OPTION_preconfig’ undeclared
(first use in this function); did you mean ‘QEMU_OPTION_writeconfig’?
             case QEMU_OPTION_preconfig:
                  ^~~~~~~~~~~~~~~~~~~~~
                  QEMU_OPTION_writeconfig

This is the same story, but with /qemu-options.def (also in .gitignore).


So 'rm ${srcdir}/qemu-version.h ${srcdir}/qemu-options.def' fixed my
problems.

Should we add a check for this kind of mistakes when running out-of-tree
builds? I'll try something.

Regards,

Phil.
