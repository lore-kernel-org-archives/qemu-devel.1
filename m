Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDUJu-0005K8-Hm
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDUJr-0003oZ-CD
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:56:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDUJr-0003nB-58
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:55:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so37343953wrw.3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 05:55:59 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-9-berrange@redhat.com>
	<2bf95805-02c8-2e69-9d31-139f2d34ca3e@redhat.com>
	<20181019124139.GQ13722@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2f48deb-46da-0e64-7b13-fe4a8d45ebe5@redhat.com>
Date: Fri, 19 Oct 2018 14:55:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181019124139.GQ13722@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 19/10/2018 14:41, Daniel P. Berrangé wrote:
> On Fri, Oct 19, 2018 at 11:57:45AM +0200, Philippe Mathieu-Daudé wrote:
>> On 09/10/2018 15:04, Daniel P. Berrangé wrote:
>>> From: "Daniel P. Berrange" <berrange@redhat.com>
>>>
>>> Add a QAuthZList object type that implements the QAuthZ interface. This
>>> built-in implementation maintains a trivial access control list with a
>>> sequence of match rules and a final default policy. This replicates the
>>> functionality currently provided by the qemu_acl module.
>>>
>>> To create an instance of this object via the QMP monitor, the syntax
>>> used would be:
>>>
>>>   {
>>>     "execute": "object-add",
>>>     "arguments": {
>>>       "qom-type": "authz-list",
>>>       "id": "authz0",
>>>       "parameters": {
>>>         "rules": [
>>>            { "match": "fred", "policy": "allow", "format": "exact" },
>>>            { "match": "bob", "policy": "allow", "format": "exact" },
>>>            { "match": "danb", "policy": "deny", "format": "glob" },
>>>            { "match": "dan*", "policy": "allow", "format": "exact" },
>>>         ],
>>>         "policy": "deny"
>>>       }
>>>     }
>>>   }
>>>
>>> This sets up an authorization rule that allows 'fred', 'bob' and anyone
>>> whose name starts with 'dan', except for 'danb'. Everyone unmatched is
>>> denied.
>>>
>>> It is not currently possible to create this via -object, since there is
>>> no syntax supported to specify non-scalar properties for objects. This
>>> is likely to be addressed by later support for using JSON with -object,
>>> or an equivalent approach.
>>>
>>> In any case the future "authz-listfile" object can be used from the
>>> CLI and is likely a better choice, as it allows the ACL to be refreshed
>>> automatically on change.
>>> +static void
>>> +qauthz_list_prop_set_policy(Object *obj,
>>> +                            int value,
>>> +                            Error **errp G_GNUC_UNUSED)
>>> +{
>>> +    QAuthZList *bauthz = QAUTHZ_LIST(obj);
>>> +
>>
>> Here:
>>
>>        g_free(bauthz->policy);
> 
> 'policy' is an integer, so I don't think we need g_free(0x1) :-)

Oops :^)

> 
>>
>>> +    bauthz->policy = value;
>>> +}
> 
> Regards,
> Daniel
> 
