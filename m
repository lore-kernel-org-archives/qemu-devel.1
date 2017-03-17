Received: from eggs.gnu.org ([2001:4830:134:3::10]:33409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cosHD-0002b8-L8
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cosH8-000535-LZ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cosH8-00051i-CQ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:50:38 -0400
References: <1489748902-21765-1-git-send-email-peter.maydell@linaro.org>
	<20170317114953.GF8050@redhat.com>
	<CAFEAcA8Sky0cX+7U257AdG=imYYcdqRgL--o=86xCHMY6Kr3zw@mail.gmail.com>
	<95e695ba-3ecc-5254-721e-b35ed08b8074@redhat.com>
	<CAFEAcA8g3iitbHPCWq9a0TrRC2Q-DiTi3ORUy_Uvt2jHjwYB8Q@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <61773eeb-112b-093b-992e-e9480a050629@redhat.com>
Date: Fri, 17 Mar 2017 14:50:32 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8g3iitbHPCWq9a0TrRC2Q-DiTi3ORUy_Uvt2jHjwYB8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Warn about deprecated hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

On 17.03.2017 14:22, Peter Maydell wrote:
> On 17 March 2017 at 13:19, Thomas Huth <thuth@redhat.com> wrote:
>> On 17.03.2017 12:52, Peter Maydell wrote:
>>> On 17 March 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> w=
rote:
>>>> On Fri, Mar 17, 2017 at 11:08:22AM +0000, Peter Maydell wrote:
>>>>> We plan to drop support in a future QEMU release for host OSes
>>>>> and host architectures for which we have no test machine where
>>>>> we can build and run tests. For the 2.9 release, make configure
>>>>> print a warning if it is run on such a host, so that the user
>>>>> has some warning of the plans and can volunteer to help us
>>>>> maintain the port if they need it to continue to function.
>>
>> I like your patch! ... but instead of completely aborting with
>> "Unsupported host OS" when an unexpected host operating system has bee=
n
>> detected, I'd maybe only print a warning and continue the configure
>> process - in case it is a POSIX-compatible system, there is at least a
>> small chance that QEMU can be compiled there.
>=20
> That code path tries to enable all the Linux specific stuff
> (including KVM and linux-user and so on) and puts linux-headers/
> on the include path. It seems very unlikely that it will actually
> work even if in theory a generic-POSIX OS might be able to build
> QEMU somehow.

Ah, sorry, you got me slightly wrong. I think it is a good idea that you
replaced the "*)" with "Linux)" in your patch. I rather meant to simply
do "echo" instead of "error_exit" in the new "*)" case.

I now just tried to build QEMU with such a "fake" generic POSIX system
(by hacking configure to not recognize "Linux"), and seems like QEMU
properly compiles in that case - but linking fails because net/tap.c is
missing a tap backend.

So you're right, currently it is not possible to build QEMU on unknown
host systems, i.e. the "error_exit" is indeed justified there (though I
think it would be maybe be possible to also add stubs for missing tap
functions to make it work).

 Thomas
