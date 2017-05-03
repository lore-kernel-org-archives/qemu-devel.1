Received: from eggs.gnu.org ([2001:4830:134:3::10]:48127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5srg-0008SM-JK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:54:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5srd-0002j1-Gy
	for qemu-devel@nongnu.org; Wed, 03 May 2017 07:54:40 -0400
References: <20170503104441.1349-1-pbonzini@redhat.com>
	<874lx21880.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e6b18bc-eb3e-c77f-2b9a-c797c3c15680@redhat.com>
Date: Wed, 3 May 2017 13:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <874lx21880.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] jazz_led: fix bad snprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, leon.alrae@imgtec.com



On 03/05/2017 13:38, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Detected by GCC 7's -Wformat-truncation.  snprintf writes at most
>> 2 bytes here including the terminating NUL, so the result is
>> truncated.  In addition, the newline at the end is pointless.
>> Fix the buffer size and the format string.
>> ---
>>  hw/display/jazz_led.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
>> index b72fdb1717..3c97d56434 100644
>> --- a/hw/display/jazz_led.c
>> +++ b/hw/display/jazz_led.c
>> @@ -227,13 +227,13 @@ static void jazz_led_invalidate_display(void *opaque)
>>  static void jazz_led_text_update(void *opaque, console_ch_t *chardata)
>>  {
>>      LedState *s = opaque;
>> -    char buf[2];
>> +    char buf[3];
>>  
>>      dpy_text_cursor(s->con, -1, -1);
>>      qemu_console_resize(s->con, 2, 1);
>>  
>>      /* TODO: draw the segments */
>> -    snprintf(buf, 2, "%02hhx\n", s->segments);
>> +    snprintf(buf, 3, "%02hhx", s->segments);
>>      console_write_ch(chardata++, ATTR2CHTYPE(buf[0], QEMU_COLOR_BLUE,
>>                                               QEMU_COLOR_BLACK, 1));
>>      console_write_ch(chardata++, ATTR2CHTYPE(buf[1], QEMU_COLOR_BLUE,
> 
> Since we're only every interested in the first two characters, the
> truncation is totally harmless.  Thus, your patch cleans doesn't really
> "fix bad snprintf", it cleans up an unclean one.  Consider rewording the
> commit message accordingly.

My reading is that buf[1] is always '\0' in the current code: "snprintf
writes at most 2 bytes here including the terminating NUL, so the result
is truncated".

Paolo

> Regardless,
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
