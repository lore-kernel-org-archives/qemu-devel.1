Received: from eggs.gnu.org ([2001:4830:134:3::10]:35246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cspuZ-0005NH-Ee
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cspuV-0001yb-DY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:07:43 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:35524
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cspuV-0001yF-2g
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:07:39 -0400
References: <20170327201146.1820-1-sw@weilnetz.de>
	<CAFEAcA-Jb8uQsQcfFfaQdXp5+DkD84tCDtMyW1kXN1yZ45fLGQ@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <7f7dd18e-1fd6-8d11-c446-58e150cd1518@weilnetz.de>
Date: Tue, 28 Mar 2017 14:07:38 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Jb8uQsQcfFfaQdXp5+DkD84tCDtMyW1kXN1yZ45fLGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developer <qemu-devel@nongnu.org>

Am 28.03.2017 um 09:10 schrieb Peter Maydell:
> On 27 March 2017 at 21:11, Stefan Weil <sw@weilnetz.de> wrote:
>> This check had several problems which are fixed here:
>>
>> * Calling "configure --help" was no longer possible on Cygwin.
>>   Fix  this by introducing a third state for supported_os and
>>   by moving the error handling code.
>>   Move the error handling code for supported_cpu, too.
>>
>> * Fix the error text. Use target cpu and target os because the
>>   build cpu and build host don't matter here.
> I think it is important that we print the deprecation
> message last, after all the other configure output.
> Otherwise it will scroll off the screen and most people
> will miss it. That's why I put it where it is.

Ok, then only the error handling for unsupported target os has
to be moved (to support ./configure --help).

>> index d1ce33bc79..902bd20070 100755
>> --- a/configure
>> +++ b/configure
>> @@ -322,7 +322,7 @@ jemalloc="no"
>>  replication="yes"
>>
>>  supported_cpu="no"
>> -supported_os="no"
>> +supported_os="deprecated"
> I don't see any need for anything other than 'yes' or 'no' ?

yes = file
no = raise error
deprecated = raise warning

Needed for delayed error handling, see below.

>>  # parse CC options first
>>  for opt do
>> @@ -440,7 +440,13 @@ int main(void) { return 0; }
>>  EOF
>>  }
>>
>> -if check_define __linux__ ; then
>> +if test "$cross_prefix" = "i686_64-w64-mingw32-" ; then
>> +  targetos='MINGW32'
>> +elif test "$cross_prefix" = "x86_64-w64-mingw32-" ; then
>> +  targetos='MINGW32'
>> +elif test -n "$cross_prefix" ; then
>> +  targetos="$cross_prefix"
> This doesn't look right. We already have too many
> cases where we determine the target OS by something
> other than looking at check_defines; one thing
> I'd like to do when we've got rid of unsupported
> OSes is to make sure that we determine the target
> OS by check_define and only by check_define.

That part of my patch is not needed. I added it because I
did not realize that "check_define" already does the correct
thing and because a wrong cross prefix raises a misleading
error message.

>> +elif check_define __linux__ ; then
>>    targetos="Linux"
>>  elif check_define _WIN32 ; then
>>    targetos='MINGW32'
>> @@ -694,7 +700,7 @@ Linux)
>>    supported_os="yes"
>>  ;;
>>  *)
>> -  error_exit "Unsupported host OS $targetos"
>> +  supported_os="no"
> This was deliberately an error_exit because anything
> going down that path got the Linux defines/includes by
> accident and we thought that would not work on
> anything else. What was using it? If we need an extra
> entry in the case statement we can add one.

It remains an error (that's why I introduced a third state for
supported_os), but must be handled later, after processing
a potential --help option.

>>      echo "CONFIG_QGA_NTDDDISK=y" >> $config_host_mak
>>    fi
>>    if test "$guest_agent_msi" = "yes"; then
>> -    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
>> +    echo "QEMU_GA_MSI_ENABLED=yes" >> $config_host_mak
>>      echo "QEMU_GA_MSI_MINGW_DLL_PATH=${QEMU_GA_MSI_MINGW_DLL_PATH}" >> $config_host_mak
>>      echo "QEMU_GA_MSI_WITH_VSS=${QEMU_GA_MSI_WITH_VSS}" >> $config_host_mak
>>      echo "QEMU_GA_MSI_ARCH=${QEMU_GA_MSI_ARCH}" >> $config_host_mak
> Stray unintended change?

Whitespace at line ending removed by my editor.

Stefan
