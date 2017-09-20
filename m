Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXpp-0002tE-0Q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duXpl-0002H4-Sf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duXpl-000285-Fx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 01:46:05 -0400
Date: Wed, 20 Sep 2017 13:45:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920054553.GU3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-6-git-send-email-peterx@redhat.com>
	<94721733-af41-690f-d17f-dbb3f7c593f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94721733-af41-690f-d17f-dbb3f7c593f5@redhat.com>
Subject: Re: [Qemu-devel] [RFC 05/15] qjson: add "opaque" field to
 JSONMessageParser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Sep 19, 2017 at 03:55:41PM -0500, Eric Blake wrote:
> On 09/14/2017 02:50 AM, Peter Xu wrote:
> > It'll be passed to emit() as well when it happens.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qapi/qmp/json-streamer.h | 8 ++++++--
> >  monitor.c                        | 7 ++++---
> >  qga/main.c                       | 5 +++--
> >  qobject/json-streamer.c          | 7 +++++--
> >  qobject/qjson.c                  | 5 +++--
> >  tests/libqtest.c                 | 5 +++--
> >  6 files changed, 24 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/qapi/qmp/json-streamer.h b/include/qapi/qmp/json-streamer.h
> > index 00d8a23..b83270c 100644
> > --- a/include/qapi/qmp/json-streamer.h
> > +++ b/include/qapi/qmp/json-streamer.h
> > @@ -25,16 +25,20 @@ typedef struct JSONToken {
> >  
> >  typedef struct JSONMessageParser
> >  {
> > -    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens);
> > +    void (*emit)(struct JSONMessageParser *parser, GQueue *tokens, void *opaque);
> >      JSONLexer lexer;
> >      int brace_count;
> >      int bracket_count;
> >      GQueue *tokens;
> >      uint64_t token_size;
> > +    /* To be passed in when emit(). */
> 
> Reads awkwardly, better might be: /* Passed to emit() */
> 
> I might group void *opaque right next to emit, rather than separated by
> the rest of the struct, to make it obvious they are related, at which
> point the comment isn't necessary.

Will remove that comment and move it upwards to emit().

> 
> > +    void *opaque;
> >  } JSONMessageParser;
> >  
> >  void json_message_parser_init(JSONMessageParser *parser,
> > -                              void (*func)(JSONMessageParser *, GQueue *));
> > +                              void (*func)(JSONMessageParser *, GQueue *,
> > +                                           void *opaque),
> 
> Inconsistent to name only one of the three parameters in the inner
> function pointer type for the outer parameter 'func'.  I wonder if a
> typedef would make things more legible.

Yep, will do.

> 
> > +                              void *opaque);
> >  
> 
> > +++ b/qobject/json-streamer.c
> > @@ -102,18 +102,21 @@ out_emit:
> >       */
> >      tokens = parser->tokens;
> >      parser->tokens = g_queue_new();
> > -    parser->emit(parser, tokens);
> > +    parser->emit(parser, tokens, parser->opaque);
> >      parser->token_size = 0;
> >  }
> >  
> >  void json_message_parser_init(JSONMessageParser *parser,
> > -                              void (*func)(JSONMessageParser *, GQueue *))
> > +                              void (*func)(JSONMessageParser *,
> > +                                           GQueue *, void *opaque),
> 
> Again, inconsistent that you named only 1 of the three inner parameters.

Fixing up.

> 
> Overall, the idea looks reasonable.

Thanks!

-- 
Peter Xu
