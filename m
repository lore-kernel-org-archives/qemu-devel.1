Received: from eggs.gnu.org ([2001:4830:134:3::10]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoSI8-0007tZ-Jm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:10:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoSI7-0000uT-Cm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:10:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoSI6-0000ss-NX
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:10:26 -0500
References: <1518761564-9899-1-git-send-email-thuth@redhat.com>
	<6ba80b39-d9c6-0d33-e7da-cfd643edaf3d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <575b9d25-eb5c-a66c-cef4-26f58f57addb@redhat.com>
Date: Wed, 21 Feb 2018 12:10:23 +0100
MIME-Version: 1.0
In-Reply-To: <6ba80b39-d9c6-0d33-e7da-cfd643edaf3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Fix problem with
 timeout due to dropped characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On 21.02.2018 12:05, Paolo Bonzini wrote:
> On 16/02/2018 07:12, Thomas Huth wrote:
>> Commit 92b540dac9fc3a5 introduce a counter to handle the timeouts in a
>> better way. But in case ccnt reaches 512, the current read character is
>> ignored - and if that character is part of the string that we are looking
>> for, the test fails to match the string.
>>
>> Almost all of the tests look for a string within the first 512 bytes of
>> firmware output, so the problem never triggered there. But the hppa test
>> that has been added recently looks for a longer string at the very end of
>> a long output, thus there's a chance that we miss a character there so
>> that the test fails unexpectedly. Fix it by *not* reading and dropping a
>> character if the counter reaches 512.
>>
>> Fixes: 92b540dac9fc3a572c7342edd0b073000f5a6abf
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  @Peter: Since this fixes the problem with running "make check", could
>>  you maybe apply this directly to the master branch? Thanks, and sorry
>>  for the inconvenience!
>>
>>  tests/boot-serial-test.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index ea87a80..696f7a3 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -101,7 +101,7 @@ static void check_guest_output(const testdef_t *test, int fd)
>>      /* Poll serial output... Wait at most 60 seconds */
>>      for (i = 0; i < 6000; ++i) {
>>          ccnt = 0;
>> -        while ((nbr = read(fd, &ch, 1)) == 1 && ccnt++ < 512) {
>> +        while (ccnt++ < 512 && (nbr = read(fd, &ch, 1)) == 1) {
>>              if (ch == test->expect[pos]) {
>>                  pos += 1;
>>                  if (test->expect[pos] == '\0') {
>>
> 
> Queued in the meanwhile, thanks.

Thanks, but Peter already applied it to fix the "make check" failures:

https://git.qemu.org/?p=qemu.git;a=commit;h=5e5432b766c424a5d1

 Thomas
