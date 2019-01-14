Received: from eggs.gnu.org ([209.51.188.92]:57823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1aV-000364-5X
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gj1aU-0003gZ-7q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:43:31 -0500
References: <1547468589-17579-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-6Z2eeB6TEUVVPBk1pBEyy7vXh-cYfLaa=XEa1iUmzRg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <096c7dbe-1780-1a8e-7b3c-b0a7770f180b@redhat.com>
Date: Mon, 14 Jan 2019 13:43:20 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6Z2eeB6TEUVVPBk1pBEyy7vXh-cYfLaa=XEa1iUmzRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Only build the s390-ccw bios if
 the compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

On 2019-01-14 13:37, Peter Maydell wrote:
> On Mon, 14 Jan 2019 at 12:24, Thomas Huth <thuth@redhat.com> wrote:
>>
>> We want to build our s390-ccw bios with -march=z900 so that it also
>> works with the oldest s390x CPU that we support with TCG. However,
>> Clang on s390x does not support -march=z900 anymore, so we can not
>> use this compiler to build the s390-ccw bios. Thus add a proper test
>> to the configure script to see whether the compiler is usable.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  configure | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 05b7e85..df34974 100755
>> --- a/configure
>> +++ b/configure
>> @@ -5906,7 +5906,10 @@ if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
>>  fi
>>
>>  if test "$cpu" = "s390x" ; then
>> -  roms="$roms s390-ccw"
>> +  # Only build the s390-ccw bios if the compiler supports -march=z900
>> +  if "$cc" -dumpspecs 2>/dev/null | grep -q "march=z900"; then
>> +    roms="$roms s390-ccw"
>> +  fi
>>  fi
> 
> clang doesn't support -dumpspecs at all, so you're implicitly
> saying "not clang" by doing the check this way... If you
> want to check "does the compiler supoprt -march=z900" why
> not do a test compile with that in the compile flags ?
> 
>    write_c_skeleton
>    if compile_prog "-march=z900" ""; then
>        roms="$roms s390-ccw"
>    fi
> 
> ?

Good idea, that seems to work fine, too. I'll send a v2...

 Thanks,
  Thomas
