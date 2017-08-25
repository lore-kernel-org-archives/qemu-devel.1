Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDCg-0008Cl-UD
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDCc-0004hO-Uc
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:55:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlDCc-0004h4-Qi
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:55:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id u11so1782521qtu.2
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 04:55:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1503592308-93913-1-git-send-email-imammedo@redhat.com>
	<1503592308-93913-2-git-send-email-imammedo@redhat.com>
	<fed7c9be-6609-75bc-61ca-b6acc67bb092@amsat.org>
	<20170825101144.5caf3e8c@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <33b192fe-72bc-be8a-00f6-0b4d4f3b3c8e@amsat.org>
Date: Fri, 25 Aug 2017 08:55:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170825101144.5caf3e8c@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 01/25] qom: cpu: fix parsed
 feature string length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 08/25/2017 05:11 AM, Igor Mammedov wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 08/24/2017 01:31 PM, Igor Mammedov wrote:
>>> since commit ( 9262685b cpu: Factor out cpu_generic_init() )
>>> features parsed by it were truncated only to the 1st feature
>>> after CPU name due to fact that
>>>
>>>      featurestr = strtok(NULL, ",");
>>>      cc->parse_features(cpu, featurestr, &err);
>>>
>>> would extract exactly one feature and parse_features() callback
>>> would parse it and only it leaving the rest of features ignored.
>>>
>>> Reuse approach from x86 custom impl. i.e. replace strtok() token
>>> parsing with g_strsplit(), which would split feature string in
>>> 2 parts name and features list and pass the later to
>>> parse_features() callback.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> CC: Eduardo Habkost <ehabkost@redhat.com>
>>> CC: Andreas Färber <afaerber@suse.de>
>>>
>>> Probably due to existing users not actualy using/having any
>>> features to parse bug were unnoticed for 2 years but switching
>>> from custom cpu_foo_init() to cpu_generic_init() triggered it.
>>> ---
>>>    qom/cpu.c | 14 ++++++--------
>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/qom/cpu.c b/qom/cpu.c
>>> index 4f38db0..caf5c14 100644
>>> --- a/qom/cpu.c
>>> +++ b/qom/cpu.c
>>> @@ -50,28 +50,26 @@ bool cpu_exists(int64_t id)
>>>    
>>>    CPUState *cpu_generic_init(const char *typename, const char *cpu_model)
>>>    {
>>> -    char *str, *name, *featurestr;
>>>        CPUState *cpu = NULL;
>>>        ObjectClass *oc;
>>>        CPUClass *cc;
>>>        Error *err = NULL;
>>> +    gchar **model_pieces;
>>>    
>>> -    str = g_strdup(cpu_model);
>>> -    name = strtok(str, ",");
>>> +    model_pieces = g_strsplit(cpu_model, ",", 2);
>>>    
>>> -    oc = cpu_class_by_name(typename, name);
>>> +    oc = cpu_class_by_name(typename, model_pieces[0]);
>>>        if (oc == NULL) {
>>> -        g_free(str);
>>> +        g_strfreev(model_pieces);
>>>            return NULL;
>>>        }
>>>    
>>>        cc = CPU_CLASS(oc);
>>> -    featurestr = strtok(NULL, ",");
>>>        /* TODO: all callers of cpu_generic_init() need to be converted to
>>>         * call parse_features() only once, before calling cpu_generic_init().
>>>         */
>>> -    cc->parse_features(object_class_get_name(oc), featurestr, &err);
>>> -    g_free(str);
>>
>> I feel safer adding:
>>
>>          if (g_strv_length(model_pieces) > 1) {
> all current callbacks (i386/sparc/cpu_common_parse_features) deal with
> 
>    cc->parse_features(,NULL,)
> 
> by explicitly checking for NULL, so there is no need for check here.
> 
> Though, it's possible to avoid calling callback at all
> if model_pieces[1] == NULL
> 
> Would you like to post a patch on top?

Ok so it is safe. I might eventually but this not a big win, so no worries.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>>
>>> +    cc->parse_features(object_class_get_name(oc), model_pieces[1], &err);
>>
>>          }
>>
>>> +    g_strfreev(model_pieces);
>>>        if (err != NULL) {
>>>            goto out;
>>>        }
>>>    
>>
> 
