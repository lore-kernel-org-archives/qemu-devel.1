Received: from eggs.gnu.org ([209.51.188.92]:49596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gpKFd-0005tJ-G7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gpKFa-00005A-H5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:52:00 -0500
Received: from smtp17.mail.ru ([94.100.176.154]:50404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gpKFX-0008VA-CZ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:51:56 -0500
References: <20190131202637.4062-1-jusual@mail.ru>
	<d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
From: Julia Suvorova <jusual@mail.ru>
Message-ID: <58da4f48-a29e-e22d-c4b3-756379e10298@mail.ru>
Date: Fri, 1 Feb 2019 00:51:50 +0300
MIME-Version: 1.0
In-Reply-To: <d21f68cf-31fa-db62-1d20-66f75e5a05b4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] monitor: Add whitelist support for QMP
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01.02.2019 0:03, Eric Blake wrote:
> On 1/31/19 2:26 PM, Julia Suvorova via Qemu-devel wrote:
>> The whitelist option allows to run a reduced monitor with a subset of
>> QMP commands. This allows the monitor to run in secure mode, which is
>> convenient for sending commands via the WebSocket monitor using the
>> web UI. This is planned to be done on micro:bit board.
>>
>> The list of allowed commands should be written to a file, one per line.
>> The command line will look like this:
>>      -mon chardev_name,mode=control,whitelist=path_to_file
>>
>> Signed-off-by: Julia Suvorova <jusual@mail.ru>
>> ---
> 
>>   
>> -void monitor_init(Chardev *chr, int flags)
>> +static void process_whitelist_file(Monitor *mon, const char *whitelist_file)
>> +{
>> +    char cmd_name[256];
>> +    FILE *fd = fopen(whitelist_file, "r");
> 
> If you use qemu_open() here (followed by fdopen if you still prefer
> fscanf over read), then you can support "/dev/fdset/NNN" to
> auto-magically support someone passing in the whitelist via an inherited
> file descriptor, rather than having to be somewhere on disk that qemu
> can directly open().

Cool, thanks!

>> +
>> +    if (fd == NULL) {
>> +        error_report("Could not open whitelist file: %s", strerror(errno));
>> +        exit(1);
>> +    }
>> +
>> +    mon->whitelist = g_hash_table_new_full(g_str_hash,
>> +                                           g_str_equal,
>> +                                           g_free,
>> +                                           NULL);
>> +
>> +    g_hash_table_add(mon->whitelist, g_strdup("qmp_capabilities"));
>> +    g_hash_table_add(mon->whitelist, g_strdup("query-commands"));
>> +
>> +    while (fscanf(fd, "%255s", cmd_name) == 1) {
> 
> %255s fits your cmd_name array declaration and stops consuming at either
> 255 bytes or at the first whitespace encountered, but where do you check
> for overflow from a file that passes more than 255 non-whitespace bytes
> without a newline?  Also, this is a bit sloppy in that it skips all
> leading whitespace, rather than ensuring that the user actually passed
> newline-separated command names.  Does glib provide any interfaces for
> more easily reading in an array of lines from a file?

With glib it would be something like that:

   g_mapped_file_new_from_fd()  : fd -> GMappedFile
   g_mapped_file_get_contents() : GMappedFile -> char *
   g_strsplit_set()             : char * -> char **

All this would need to be released afterwards.
Do you think it would be better?

Best regards, Julia Suvorova.
