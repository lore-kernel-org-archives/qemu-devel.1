Received: from eggs.gnu.org ([2001:4830:134:3::10]:41746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimuW-0006Rk-Ts
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cimuW-0000mk-1K
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 13:54:09 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-23-git-send-email-armbru@redhat.com>
	<20170228180256.GX4090@noname.redhat.com>
Date: Tue, 28 Feb 2017 19:54:00 +0100
In-Reply-To: <20170228180256.GX4090@noname.redhat.com> (Kevin Wolf's message
	of "Tue, 28 Feb 2017 19:02:56 +0100")
Message-ID: <874lzejgdz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 22/24] qapi: New parse_qapi_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> Am 27.02.2017 um 12:20 hat Markus Armbruster geschrieben:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/qapi/util.h    |  2 ++
>>  qapi/qapi-util.c       | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/test-qapi-util.c | 34 ++++++++++++++++++++++++++++++++++
>>  3 files changed, 83 insertions(+)
>> 
>> diff --git a/include/qapi/util.h b/include/qapi/util.h
>> index 7ad26c0..7436ed8 100644
>> --- a/include/qapi/util.h
>> +++ b/include/qapi/util.h
>> @@ -14,4 +14,6 @@
>>  int qapi_enum_parse(const char * const lookup[], const char *buf,
>>                      int max, int def, Error **errp);
>>  
>> +int parse_qapi_name(const char *name, bool complete);
>> +
>>  #endif
>> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
>> index 818730a..53b27e2 100644
>> --- a/qapi/qapi-util.c
>> +++ b/qapi/qapi-util.c
>> @@ -33,3 +33,50 @@ int qapi_enum_parse(const char * const lookup[], const char *buf,
>>      error_setg(errp, "invalid parameter value: %s", buf);
>>      return def;
>>  }
>> +
>> +/*
>> + * Parse a valid QAPI name from @str.
>> + * A valid name consists of letters, digits, hyphen and underscore.
>> + * It may be prefixed by __RFQDN_ (downstream extension), where RFQDN
>> + * may contain only letters, digits and hyphen.
>
> And '.' according to the code below.

Of course.  Fixing the comment...

>> + * The special exception for enumeration names is not implemented.
>> + * See docs/qapi-code-gen.txt for more on QAPI naming rules.
>> + * Keep this consistent with scripts/qapi.py!
>> + * If @complete, the parse fails unless it consumes @str completely.
>> + * Return its length on success, -1 on failure.
>> + */
>
> Kevin
