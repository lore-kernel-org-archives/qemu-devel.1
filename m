Received: from eggs.gnu.org ([209.51.188.92]:37505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJEa-0001NW-Ab
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJ53-00018M-LM
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:16:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:39383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hCJ53-00014z-9S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:16:05 -0400
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<e0959fcc-df89-1d64-e512-924c25106dc0@redhat.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <87b3bdc4-3e35-c81b-bd41-7817fc70e9e5@gmx.de>
Date: Fri, 5 Apr 2019 09:14:08 +0200
MIME-Version: 1.0
In-Reply-To: <e0959fcc-df89-1d64-e512-924c25106dc0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

Hi Philippe,

On 04.04.19 21:24, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Helge,
>
> On 4/4/19 8:57 PM, Helge Deller wrote:
>> If a non-release architecture is found, and it's known that there is no
>> native TCG support for that CPU, automatically fall back to the TCI
>> implementation instead of requesting the user to run configure again
>> with the --enable-tcg-interpreter option.
>>
>> This change simplifies building qemu in automatic build environments
>> (like in my case the debian buildds) because one does not need to
>> special case on the architectures.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/configure b/configure
>> index 1c563a7027..8fe4fc84d8 100755
>> --- a/configure
>> +++ b/configure
>> @@ -769,8 +769,10 @@ case "$cpu" in
>>      cross_cc_sparc=3D$host_cc
>>    ;;
>>    *)
>> -    # This will result in either an error or falling back to TCI later
>> +    # Fall back to TCI on unsupported CPUs
>>      ARCH=3Dunknown
>> +    echo "Unsupported '$cpu' CPU found. Will use TCG with TCI (experim=
ental)."
>> +    tcg_interpreter=3D"yes"
>
> I'm not comfortable with this change... I'd prefer to keep the explicit
> flag. Is your debian buildd targetting mainstream QEMU or the Debian
> package? Can't you manage this as a Debian specific patch?

I tried to get it added as debian specific patch a few times.

> Else, why not add a "hppa" case selecting TCI in the switch? This would
> be less invasive.

If that would be acceptable, I'm happy to send a new patch.

Helge

>>    ;;
>>  esac
>>  if test -z "$ARCH"; then
>> @@ -1855,16 +1857,6 @@ if ! compile_prog ; then
>>      error_exit "\"$cc\" cannot build an executable (is your linker bro=
ken?)"
>>  fi
>>
>> -# Now we have handled --enable-tcg-interpreter and know we're not just
>> -# printing the help message, bail out if the host CPU isn't supported.
>> -if test "$ARCH" =3D "unknown"; then
>> -    if test "$tcg_interpreter" =3D "yes" ; then
>> -        echo "Unsupported CPU =3D $cpu, will use TCG with TCI (experim=
ental)"
>> -    else
>> -        error_exit "Unsupported CPU =3D $cpu, try --enable-tcg-interpr=
eter"
>> -    fi
>> -fi
>> -
>>  # Consult white-list to determine whether to enable werror
>>  # by default.  Only enable by default for git builds
>>  if test -z "$werror" ; then
>>
