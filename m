Received: from eggs.gnu.org ([2001:4830:134:3::10]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDULT-0006on-FN
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDULQ-00076S-4I
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:57:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDULP-0006pU-Qh
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:57:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id f17-v6so5569182wrs.12
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 05:57:23 -0700 (PDT)
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-10-berrange@redhat.com>
	<b1d61bfd-cc34-2103-35a1-86bd828e7a93@redhat.com>
	<20181019125342.GS13722@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7930fab5-735a-ffbb-c279-4a4148ea4c4a@redhat.com>
Date: Fri, 19 Oct 2018 14:57:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181019125342.GS13722@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 09/11] authz: add QAuthZListFile object
 type for a file access control list
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

On 19/10/2018 14:53, Daniel P. Berrangé wrote:
> On Fri, Oct 19, 2018 at 11:41:45AM +0200, Philippe Mathieu-Daudé wrote:
>> On 09/10/2018 15:04, Daniel P. Berrangé wrote:
>>> Add a QAuthZListFile object type that implements the QAuthZ interface. This
>>> built-in implementation is a proxy around the QAtuhZList object type,
>>> initializing it from an external file, and optionally, automatically
>>> reloading it whenever it changes.
>>>
>>> To create an instance of this object via the QMP monitor, the syntax
>>> used would be:
>>>
>>>       {
>>>         "execute": "object-add",
>>>         "arguments": {
>>>           "qom-type": "authz-list-file",
>>>           "id": "authz0",
>>>           "parameters": {
>>>             "filename": "/etc/qemu/vnc.acl",
>>> 	    "refresh": "yes"
>>>           }
>>>         }
>>>       }
>>>
>>> If "refresh" is "yes", inotify is used to monitor the file,
>>> automatically reloading changes. If an error occurs during reloading,
>>> all authorizations will fail until the file is next successfully
>>> loaded.
>>>
>>> The /etc/qemu/vnc.acl file would contain a JSON representation of a
>>> QAuthZList object
>>>
>>>     {
>>>       "rules": [
>>>          { "match": "fred", "policy": "allow", "format": "exact" },
>>>          { "match": "bob", "policy": "allow", "format": "exact" },
>>>          { "match": "danb", "policy": "deny", "format": "glob" },
>>>          { "match": "dan*", "policy": "allow", "format": "exact" },
>>>       ],
>>>       "policy": "deny"
>>>     }
>>>
>>> This sets up an authorization rule that allows 'fred', 'bob' and anyone
>>> whose name starts with 'dan', except for 'danb'. Everyone unmatched is
>>> denied.
>>>
>>> The object can be loaded on the comand line using
>>>
>>>    -object authz-list-file,id=authz0,filename=/etc/qemu/vnc.acl,refresh=yes
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  authz/Makefile.objs      |   1 +
>>>  authz/listfile.c         | 284 +++++++++++++++++++++++++++++++++++++++
>>>  authz/trace-events       |   4 +
>>>  include/authz/listfile.h | 110 +++++++++++++++
>>>  qemu-options.hx          |  47 +++++++
>>>  5 files changed, 446 insertions(+)
>>>  create mode 100644 authz/listfile.c
>>>  create mode 100644 include/authz/listfile.h
>>>
> 
>>> +static void
>>> +qauthz_list_file_event(int wd G_GNUC_UNUSED,
>>> +                       QFileMonitorEvent ev G_GNUC_UNUSED,
>>> +                       const char *name G_GNUC_UNUSED,
>>> +                       void *opaque)
>>> +{
>>> +    QAuthZListFile *fauthz = opaque;
>>> +    Error *err = NULL;
>>> +
>>> +    if (ev != QFILE_MONITOR_EVENT_MODIFIED &&
>>> +        ev != QFILE_MONITOR_EVENT_CREATED)
>>
>> You missed:
>>
>>                                               {
>>
>>> +        return;
>>
>>        }
> 
> Opps, yes.
> 
> 
>>> +static void
>>> +qauthz_list_file_complete(UserCreatable *uc, Error **errp)
>>> +{
>>> +    QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(uc);
>>> +
>>> +    fauthz->list = qauthz_list_file_load(fauthz, errp);
>>> +
>>> +    if (fauthz->refresh) {
>>
>> Can we invert this condition?
> 
> Yes, will do
> 
>>
>>> +        gchar *dir, *file;
>>> +        fauthz->file_monitor = qemu_file_monitor_get_instance(errp);
>>> +        if (!fauthz->file_monitor) {
>>> +            return;
>>> +        }
>>> +
>>> +        dir = g_path_get_dirname(fauthz->filename);
>>> +        if (g_str_equal(dir, ".")) {
>>> +            error_setg(errp, "Filename must be an absolute path");
>>
>> What about:
>>
>>                goto cleanup;
> 
> Yep.
> 
>>
>>> +            g_free(dir);
>>> +            return;
>>> +        }
>>> +        file = g_path_get_basename(fauthz->filename);
>>> +        if (g_str_equal(file, ".")) {
>>> +            error_setg(errp, "Path has no trailing filename component");
>>
>>                goto cleanup;
>>
>>> +            g_free(file);
>>> +            g_free(dir);
>>> +            return;
>>> +        }
>>> +
>>> +        fauthz->file_watch = qemu_file_monitor_add_watch(
>>> +            fauthz->file_monitor, dir, file,
>>> +            qauthz_list_file_event, fauthz, errp);
>>> +        g_free(file);
>>> +        g_free(dir);
>>> +        if (fauthz->file_watch < 0) {
>>
>> Is this really useful? Do you plan to add more code here?
> 
> I just want to make it clear to anyone who changes the code
> in future that there's an expected failure condition here.

I thought so. Just add a simple /* comment */ about it :)

> 
>>> +            return;
>>> +        }
>>> +    }
>>> +}
> 
> Regards,
> Daniel
> 
