Received: from eggs.gnu.org ([2001:4830:134:3::10]:57691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTpCJ-0005yZ-Fg
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTpCG-0007aP-Rj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTpCG-0007a2-Kj
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:27:40 -0500
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
	<1543845937-300-2-git-send-email-thuth@redhat.com>
	<20181203141611.GG8870@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bbaa2b99-9503-3c35-f933-01c0e0cb0368@redhat.com>
Date: Mon, 3 Dec 2018 15:27:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181203141611.GG8870@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, pbonzini@redhat.com, peter.maydell@linaro.org

On 2018-12-03 15:16, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Dec 03, 2018 at 03:05:31PM +0100, Thomas Huth wrote:
>> So far we only had implicit requirements for the minimum compiler vers=
ion,
>> e.g. we require at least GCC 4.1 for the support of atomics. However,
>> such old compiler versions are not tested anymore by the developers, s=
o
>> they are not really supported anymore. Since we recently declared expl=
icitly
>> what platforms we intend to support, we can also get more explicit on =
the
>> compiler version now. The supported distributions use the following ve=
rsion
>> of GCC:
>>
>>       RHEL-7: 4.8.5
>>       Debian (Stretch): 6.3.0
>>       Debian (Jessie): 4.8.4
>>       OpenBSD (ports): 4.9.4
>>       FreeBSD (ports): 8.2.0
>>       OpenSUSE Leap 15: 7.3.1
>>       Ubuntu (Xenial): 5.3.1
>>       macOS (Homebrew): 8.2.0
>>
>> So we can safely assume GCC 4.8 these days. For Clang, the situation i=
s
>> a little bit more ambiguous, since it is sometimes not available in th=
e
>> main distros but rather third party repositories. At least Debian Jess=
ie
>> uses version 3.5, and EPEL7 for RHEL7 uses 3.4, so let's use 3.4 as
>> minimum Clang version now - we still can adjust this later if necessar=
y.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  configure | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/configure b/configure
>> index 0a3c6a7..f1e305e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1840,6 +1840,25 @@ if test "$bogus_os" =3D "yes"; then
>>      error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')=
"
>>  fi
>> =20
>> +# Check whether the compiler matches our minimum requirements:
>> +cat > $TMPC << EOF
>> +#if defined(__clang_major__) && defined(__clang_minor__)
>> +# if __clang_major__ < 3 || (__clang_major__ =3D=3D 3 && __clang_mino=
r__ < 4)
>> +#  error You need at least Clang v3.4 to compile QEMU
>> +# endif
>=20
> NB although this will succeed, it is not technically checking the
> right thing on macOS platforms as their clang used a completely
> different numbering scheme. It just happens to have larger numbers
> than upstream clang, so we'll always succeed.

Does that only apply to the version string that is reported by "clang
--version" or does it also apply to the __clang_major/minor__ macros?

In the latter case, I think I could add a comment to the patch here.

I'm also not sure whether the LLVM version necessarily matches the Clang
version? In older versions, you can also see "4.2 (clang-425.0.28)
(based on LLVM 3.2svn)" in the tables there...

> IOW, to require clang >=3D 3.4 on macOS, we would need to require
> their version >=3D 5.1

If they also messed up the macros, I think we likely have a problem the
other way round: What upstream Clang version corresponds to the Apple
Clang version 3.4 ? ... but if I interpret the old table right, they
just started the confusion with 5.0, so I think the check above should
still be fine.

 Thomas
