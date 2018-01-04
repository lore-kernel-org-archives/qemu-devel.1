Received: from eggs.gnu.org ([2001:4830:134:3::10]:60830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX92A-0003uI-Nq
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX924-0001IK-R2
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:26 -0500
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX924-0001HL-Ia
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:10:20 -0500
Received: by mail-qt0-x232.google.com with SMTP id i40so2655314qti.8
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 09:10:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-13-marcandre.lureau@redhat.com>
	<3c07180c-f65c-fdcf-fb53-2369f6af5cf6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5052f6a1-34b3-1088-c4c6-fb2cfefa3b44@amsat.org>
Date: Thu, 4 Jan 2018 14:10:16 -0300
MIME-Version: 1.0
In-Reply-To: <3c07180c-f65c-fdcf-fb53-2369f6af5cf6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 12/18] crypto: fix stack-buffer-overflow
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

On 01/04/2018 01:40 PM, Thomas Huth wrote:
> On 04.01.2018 17:05, Marc-André Lureau wrote:
>> ASAN complains about:
>>
>> ==8856==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x7ffd8a1fe168 at pc 0x561136cb4451 bp 0x7ffd8a1fe130 sp 0x7ffd8a1fd8e0
>> READ of size 16 at 0x7ffd8a1fe168 thread T0
>>     #0 0x561136cb4450 in __asan_memcpy (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x110450)
>>     #1 0x561136d2a6a7 in qcrypto_ivgen_essiv_calculate /home/elmarco/src/qq/crypto/ivgen-essiv.c:83:5
>>     #2 0x561136d29af8 in qcrypto_ivgen_calculate /home/elmarco/src/qq/crypto/ivgen.c:72:12
>>     #3 0x561136d07c8e in test_ivgen /home/elmarco/src/qq/tests/test-crypto-ivgen.c:148:5
>>     #4 0x7f77772c3b04 in test_case_run /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2237
>>     #5 0x7f77772c3ec4 in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2321
>>     #6 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
>>     #7 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
>>     #8 0x7f77772c3f6d in g_test_run_suite_internal /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2333
>>     #9 0x7f77772c4184 in g_test_run_suite /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:2408
>>     #10 0x7f77772c2e0d in g_test_run /home/elmarco/src/gnome/glib/builddir/../glib/gtestutils.c:1674
>>     #11 0x561136d0799b in main /home/elmarco/src/qq/tests/test-crypto-ivgen.c:173:12
>>     #12 0x7f77756e6039 in __libc_start_main (/lib64/libc.so.6+0x21039)
>>     #13 0x561136c13d89 in _start (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x6fd89)
>>
>> Address 0x7ffd8a1fe168 is located in stack of thread T0 at offset 40 in frame
>>     #0 0x561136d2a40f in qcrypto_ivgen_essiv_calculate /home/elmarco/src/qq/crypto/ivgen-essiv.c:76
>>
>>   This frame has 1 object(s):
>>     [32, 40) 'sector.addr' <== Memory access at offset 40 overflows this variable
>> HINT: this may be a false positive if your program uses some custom stack unwind mechanism or swapcontext
>>       (longjmp and C++ exceptions *are* supported)
>> SUMMARY: AddressSanitizer: stack-buffer-overflow (/home/elmarco/src/qq/build/tests/test-crypto-ivgen+0x110450) in __asan_memcpy
>> Shadow bytes around the buggy address:
>>   0x100031437bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> =>0x100031437c20: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00[f3]f3 f3
>>   0x100031437c30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   0x100031437c70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> Shadow byte legend (one shadow byte represents 8 application bytes):
>>   Addressable:           00
>>   Partially addressable: 01 02 03 04 05 06 07
>>   Heap left redzone:       fa
>>   Freed heap region:       fd
>>   Stack left redzone:      f1
>>   Stack mid redzone:       f2
>>   Stack right redzone:     f3
>>   Stack after return:      f5
>>   Stack use after scope:   f8
>>   Global redzone:          f9
>>   Global init order:       f6
>>   Poisoned by user:        f7
>>   Container overflow:      fc
>>   Array cookie:            ac
>>   Intra object redzone:    bb
>>   ASan internal:           fe
>>   Left alloca redzone:     ca
>>   Right alloca redzone:    cb
>>
>> It looks like the rest of the code copes with ndata being larger than
>> sizeof(sector), so limit the memcpy() range.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
>> ---
>>  crypto/ivgen-essiv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
>> index cba20bde6c..ad4d926c19 100644
>> --- a/crypto/ivgen-essiv.c
>> +++ b/crypto/ivgen-essiv.c
>> @@ -79,7 +79,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
>>      uint8_t *data = g_new(uint8_t, ndata);
>>  
>>      sector = cpu_to_le64(sector);
>> -    memcpy(data, (uint8_t *)&sector, ndata);
>> +    memcpy(data, (uint8_t *)&sector, MIN(sizeof(sector), ndata));
>>      if (sizeof(sector) < ndata) {
>>          memset(data + sizeof(sector), 0, ndata - sizeof(sector));
>>      }
>>
> 
> Ah, funny, completely unaware of your patch series, I accidentally came
> to the same conclusion two days ago:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00062.html
> 
> So if you like, feel free to add:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Or share a Signed-off-by? :)
