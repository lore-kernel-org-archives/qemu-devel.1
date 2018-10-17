Received: from eggs.gnu.org ([2001:4830:134:3::10]:37656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCm4V-0005oU-Gf
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCm4S-0004gF-8j
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCm4S-0004dt-11
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:41:08 -0400
References: <20181016174158.15229-1-armbru@redhat.com>
	<20181016174158.15229-9-armbru@redhat.com>
	<20181017091516.35af8b13@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fdc256c3-a748-4524-6913-79b2eb90460a@redhat.com>
Date: Wed, 17 Oct 2018 08:41:04 -0500
MIME-Version: 1.0
In-Reply-To: <20181017091516.35af8b13@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/38] 9pfs: Fix CLI parsing crash on
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 10/17/18 2:15 AM, Greg Kurz wrote:
> On Tue, 16 Oct 2018 19:41:28 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
>> Calling error_report() in a function that takes an Error ** argument
>> is suspicious.  9p-handle.c's handle_parse_opts() does that, and then
>> fails without setting an error.  Wrong.  Its caller crashes when it
>> tries to report the error:
>>
>>      $ qemu-system-x86_64 -nodefaults -fsdev id=foo,fsdriver=handle
>>      qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: warning: handle backend is deprecated
>>      qemu-system-x86_64: -fsdev id=foo,fsdriver=handle: fsdev: No path specified
>>      Segmentation fault (core dumped)
>>
>> Screwed up when commit 91cda4e8f37 (v2.12.0) converted the function to
>> Error.  Fix by calling error_setg() instead of error_report().
>>
>> Fixes: 91cda4e8f372602795e3a2f4bd2e3adaf9f82255
>> Cc: Greg Kurz <groug@kaod.org>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Acked-by: Greg Kurz <groug@kaod.org>
>> ---
> 
> Hi Markus,
> 
> FWIW you had a Reviewed-by from Eric.
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg03297.html

Most likely crossed mail. Although I composed my v2 review Monday, an 
ISP outage prevented it from hitting the list until Tuesday after Markus 
had prepared v3. (And the fact that a small fire near Dallas was able to 
take out internet access for more than a million AT&T customers for more 
than 12 hours makes you appreciate how much we really rely on the 
Internet in modern society)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
