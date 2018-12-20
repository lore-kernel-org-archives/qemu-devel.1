Received: from eggs.gnu.org ([2001:4830:134:3::10]:38472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ga3UA-0001y6-K8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ga3U8-0006oc-F0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:55:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ga3U6-0006lp-PP
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:55:51 -0500
References: <20181220123655.30475-1-pbonzini@redhat.com>
	<CAFEAcA_=kHDpwcwnEaVEAfD8fQ_UkjKcs_+k_DpQpo9KvF_nhg@mail.gmail.com>
	<CAFEAcA-AKFxFOdd8PMKC0aMb_NPvhu0KMVcgOP+wUNfy5Qh84g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b32a63f-b628-89aa-1860-5f304a1fd7ba@redhat.com>
Date: Thu, 20 Dec 2018 19:55:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-AKFxFOdd8PMKC0aMb_NPvhu0KMVcgOP+wUNfy5Qh84g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20/12/18 18:41, Peter Maydell wrote:
>> This seemed to work on most of my test hosts but something
>> weird happened here: hyperlong repetitive command line and
>> looks like make got an "fwrite(): Resource temporarily unavailable"
>> halfway through writing it out??
>>
>> This was on my x86-64 Linux Ubuntu system, clang build
>> which I configure with '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
>> '--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base -=
Werror';
>> the error is during the 'make -C build/clang check V=3D1' phase.
>=20
> Checking my logfiles I think that the previous pull request
> apply attempt also failed this way, but I didn't notice
> because of the other failures on other hosts. It may be
> the combination of the huge command line and the way my
> test setup uses GNU parallel and ssh to capture the make
> output into a logfile.

Ok, I got it even better than the old harness.  Now each test is printed
individually and the V=3D1 command lines are very easily cut-and-pasted:

  TEST    check-qtest-x86_64: tests/endianness-test
  TEST    check-qtest-x86_64: tests/fdc-test
  TEST    check-qtest-x86_64: tests/ide-test
  TEST    check-qtest-x86_64: tests/ahci-test

With V=3D1:

export MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img; tests/endianness-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"endianness-test"
PASS 1 endianness-test /x86_64/endianness/pc
PASS 2 endianness-test /x86_64/endianness/split/pc
PASS 3 endianness-test /x86_64/endianness/combine/pc
export MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
QTEST_QEMU_IMG=3Dqemu-img; tests/fdc-test -m=3Dquick -k --tap |
./scripts/tap-driver.pl --test-name=3D"fdc-test"
PASS 1 fdc-test /x86_64/fdc/cmos
PASS 2 fdc-test /x86_64/fdc/no_media_on_start
PASS 3 fdc-test /x86_64/fdc/read_without_media

...

(as long as you don't use -k).  Thanks for the test.

Paolo
