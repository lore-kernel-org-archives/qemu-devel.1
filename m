Received: from eggs.gnu.org ([2001:4830:134:3::10]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dhFn3-0007P0-Nh
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dhFn0-0003m0-HJ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dhFn0-0003gx-7h
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 09:52:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B7DB61D38
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 13:44:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170811152256.GS2554@redhat.com> (Daniel P. Berrange's message
	of "Fri, 11 Aug 2017 16:22:56 +0100")
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-12-quintela@redhat.com>
	<20170811152256.GS2554@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 14 Aug 2017 15:43:58 +0200
Message-ID: <87shguxo0x.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 11/19] migration: Start of multiple fd
 work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Tue, Aug 08, 2017 at 06:26:21PM +0200, Juan Quintela wrote:
>> We create new channels for each new thread created. We send through
>> them a string containing <uuid> multifd <channel number> so we are
>> sure that we connect the right channels in both sides.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 

>> +/* Default uuid for multifd when qemu is not started with uuid */
>> +static char multifd_uuid[] = "5c49fd7e-af88-4a07-b6e8-091fd696ad40";
>
> Why is this better than just using the qemu_uuid unconditionally.
> UUIC, it'll just be 00000000-0000-0000-0000-000000000000.
>
> Either way you've got a non-unique UUID if multiple QEMUs are
> started, so I dont see a benefit in inventing a new uuid here.

I hate a message full of zeros, it is the default value.  If you have
more than one qemu and you don't set uuid, you are asking for trouble.

But if people preffer the 00000 uuid, it is also ok with me.

>
>> +/* strlen(multifd) + '-' + <channel id> + '-' +  UUID_FMT + '\0' */
>> +#define MULTIFD_UUID_MSG (7 + 1 + 3 + 1 + UUID_FMT_LEN + 1)
>> +
>>  static void *multifd_send_thread(void *opaque)
>>  {
>>      MultiFDSendParams *p = opaque;
>> +    char *string;
>> +    char *string_uuid;
>> +
>> +    if (qemu_uuid_set) {
>> +        string_uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
>> +    } else {
>> +        string_uuid = g_strdup(multifd_uuid);
>> +    }
>> +    string = g_strdup_printf("%s multifd %03d", string_uuid, p->id);
>> +    g_free(string_uuid);
>> +    qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
>
> Must check return code here as it can do a short write, which won't
> trigger error_abort.  Also you must not use error_abort at all. QEMU
> must not abort when migration hits an I/O error as that needlessly
> kills the user's VM.
>
> I also think it is not nice to be formatting a string with printf
> here, sending it and then using scanf to extract the data. If we
> need to send structured data, then we should define a proper binary
> format for it eg 
>
>   struct MigrateUUIDMsg {
>       uint32_t chnanelid;
>       QemuUUID uuid;
>   } __attribute__((__packed__));
>
> and then just send the raw struct across.

Not that I believe that it still works (or that it worked ever), but
qemu migration "on stream" was supposed to be Endian safe .....

>> +    g_free(string);
>>  
>>      while (true) {
>>          qemu_mutex_lock(&p->mutex);
>> @@ -445,6 +467,12 @@ int multifd_save_setup(void)
>>          qemu_sem_init(&p->sem, 0);
>>          p->quit = false;
>>          p->id = i;
>> +        p->c = socket_send_channel_create();
>> +        if (!p->c) {
>> +            error_report("Error creating a send channel");
>> +            multifd_save_cleanup();
>> +            return -1;
>> +        }
>
> We should pass an 'Error *' object into socket_send_channel_create()
> so that we can receive  & report the actual error message, instead
> of a useless generic message.

Yeap, that is what I told was doing next on the Cover letter.
Just that it means changing lots of functions prototypes ....


>> +    qio_channel_read(ioc, string, sizeof(string), &error_abort);
>
> Must not use error_abort which kills the whole VM ungracefully

Changing also that.

>
>> +    sscanf(string, "%s multifd %03d", string_uuid, &id);
>> +
>> +    if (qemu_uuid_set) {
>> +        uuid = qemu_uuid_unparse_strdup(&qemu_uuid);
>> +    } else {
>> +        uuid = g_strdup(multifd_uuid);
>> +    }
>> +    if (strcmp(string_uuid, uuid)) {
>> +        error_report("multifd: received uuid '%s' and expected uuid '%s'"
>> +                     " for channel %d", string_uuid, uuid, id);
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +                          MIGRATION_STATUS_FAILED);
>> +        terminate_multifd_recv_threads();
>> +        return;
>> +    }
>> +    g_free(uuid);
>
> As mentioned above, we should receive a binary struct here instead
> of playing games with scanf.

>> @@ -534,22 +612,15 @@ int multifd_load_setup(void)
>>      multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>>      multifd_recv_state->params = g_new0(MultiFDRecvParams *, thread_count);
>>      multifd_recv_state->count = 0;
>> -    for (i = 0; i < thread_count; i++) {
>> -        char thread_name[16];
>> -        MultiFDRecvParams *p = multifd_recv_state->params[i];
>> -
>> -        qemu_mutex_init(&p->mutex);
>> -        qemu_sem_init(&p->sem, 0);
>> -        p->quit = false;
>> -        p->id = i;
>> -        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
>> -        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
>> -                           QEMU_THREAD_JOINABLE);
>> -        multifd_recv_state->count++;
>> -    }
>
> It us a little strange to be deleting a bunch of code you just added in the
> previous patch

We create the send/recv channels on previous patch.  And then we switch
to create them as we receive the connections.  I will try to see if
creating first the receiving threads it gets clearer.


>>  static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
>>  {
>> @@ -96,6 +128,9 @@ static void socket_start_outgoing_migration(MigrationState *s,
>>      struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
>>  
>>      data->s = s;
>> +    outgoing_args.saddr = saddr;
>> +    outgoing_args.errp = errp;
>
> Taking a stack local 'errp' pointer and saving it for later use
> in a global variable is asking for trouble. There's no guarantee
> that stack frame will still be valid when 'outgoing_args.errp'
> is later used. 

Yeap, changing to an Error * pointer by thread.

Thanks, Juan.
