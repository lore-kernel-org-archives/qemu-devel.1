Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVCLO-0004wl-Iu
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gVCLK-00078j-GB
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:22:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gVCLI-00077O-EV
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 04:22:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 197F0804F5
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 09:22:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181206232333.22408-1-pbonzini@redhat.com>
	<20181206232333.22408-5-pbonzini@redhat.com>
Date: Fri, 07 Dec 2018 10:22:37 +0100
In-Reply-To: <20181206232333.22408-5-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Fri, 7 Dec 2018 00:23:31 +0100")
Message-ID: <87a7lh1yjm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/6] qemu/queue.h: reimplement QTAILQ
 without pointer-to-pointers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> QTAILQ is a doubly linked list, with a pointer-to-pointer to the last
> element from the head, and the previous element from each node.
>
> But if you squint enough, QTAILQ becomes a combination of a singly-linked
> forwards list, and another singly-linked list which goes backwards and
> is circular.  This is the idea that lets QTAILQ implement reverse
> iteration: only, because the backwards list points inside the node,
> accessing the previous element needs to go two steps back and one
> forwards.
>
> What this patch does is implement it in these terms, without actually
> changing the in-memory layout at all.  The coexistence of the two lists
> is realized by making QTAILQ_HEAD and QTAILQ_ENTRY unions of the forwards
> pointer and a generic QTailQLink node.  Thq QTailQLink can walk the list in

s/Thq/The/

> both directions; the union is needed so that the forwards pointer can
> have the correct type, as a sort of poor man's template.  While there
> are other ways to get the same layout without a union, this one has
> the advantage of simpler operation in the debugger, because the fields
> tqh_first and tqe_next still exist as before the patch.  Those fields are
> also used by scripts/qemugdb/mtree.py, so it's a good idea to preserve them.
>
> The advantage of the new representation is that the two-back-one-forward
> dance done by backwards accesses can be done all while operating on
> QTailQLinks.  No casting to the head struct is needed anymore because,
> even though the QTailQLink's forward pointer is a void *, we can use
> typeof to recover the correct type.  This patch only changes the
> implementation, not the interface.  The next patch will remove the head
> struct name from the backwards visit macros.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/queue.h       | 143 ++++++++++++++++---------------------
>  include/qemu/rcu_queue.h   |  45 ++++++------
>  scripts/cocci-macro-file.h |  24 ++-----
>  3 files changed, 93 insertions(+), 119 deletions(-)
>
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index ac418efc43..cb1bd6327c 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -346,77 +346,80 @@ struct {                                                                \
>  #define QSIMPLEQ_FIRST(head)        ((head)->sqh_first)
>  #define QSIMPLEQ_NEXT(elm, field)   ((elm)->field.sqe_next)
>  
> +typedef struct QTailQLink {
> +    void *tql_next;
> +    struct QTailQLink *tql_prev;
> +} QTailQLink;
>  
>  /*
> - * Tail queue definitions.
> + * Tail queue definitions.  The union acts as a poor man template, as if
> + * it were QTailQLink<type>.
>   */
> -#define Q_TAILQ_HEAD(name, type, qual)                                  \
> -struct name {                                                           \
> -        qual type *tqh_first;           /* first element */             \
> -        qual type *qual *tqh_last;      /* addr of last next element */ \
> +#define QTAILQ_HEAD(name, type)                                         \
> +union name {                                                            \
> +        struct type *tqh_first;       /* first element */               \
> +        QTailQLink tqh_circ;          /* link for circular backwards list */ \
>  }
> -#define QTAILQ_HEAD(name, type)  Q_TAILQ_HEAD(name, struct type,)
>  
>  #define QTAILQ_HEAD_INITIALIZER(head)                                   \
> -        { NULL, &(head).tqh_first }
> +        { .tqh_circ = { NULL, &(head).tqh_circ } }
>  
> -#define Q_TAILQ_ENTRY(type, qual)                                       \
> -struct {                                                                \
> -        qual type *tqe_next;            /* next element */              \
> -        qual type *qual *tqe_prev;      /* address of previous next element */\
> +#define QTAILQ_ENTRY(type)                                              \
> +union {                                                                 \
> +        struct type *tqe_next;        /* next element */                \
> +        QTailQLink tqe_circ;          /* link for circular backwards list */ \
>  }
> -#define QTAILQ_ENTRY(type)       Q_TAILQ_ENTRY(struct type,)

I think this conflates two things:

(a) The one advertized by the commit message, and

(b) Getting rid of Q_TAILQ_HEAD(), Q_TAILQ_ENTRY() as unnecessary
complications.

I suspect doing (b) first in a separate patch would make (a) a bit
easier to review.

The way my brain works, I need to redo your explanation my own way;
reading your (undoubtedly fine) commit message won't do.

Let me start with examining (a) in the light of "no change of the
in-memory layout".

The head is a pair of pointers.  Before the patch, they are

    struct T *tqh_first;
    struct T **tqh_last;

The patch changes tqh_first from the first member of a struct into the
first member of a union, which is effectively the same.  Okay.

It adds tqh_circ.tql_next as alias of type void *.  Exploits uniform
pointer representation on sane machines.  Okay.

It replaces tqh_last by tqh_circ.tql_prev, changing its type from struct
T ** to QTailQLink *.  

The entry has the same structure, only the names are different.

tqe_next stays the same, with new alias tqe_circ.tql_next.

tqe_prev gets replaced by tqe_circ.tql_prev.

The commit message claims the QTailQLink permits walking the list in
both directions.  True: ->tqe_next->FIELD.tqe_circ is the next
QTailQLink, and ->tql_prev points to the previous one.

To go from QTailQLink to the T that contains it, we can
->tql_prev->tql->next (the backward list is circular).  This yields a
void *, which we need to cast to struct T *.

The cast to struct T * can be done without having to name struct T when
we have a head or an entry: typeof ->tqh_first or ->tqe_next does the
trick.

Yup, that should work.  I figure the changes below are actually almost
mechanical.

Or did I screw up somewhere?

>  
>  /*
>   * Tail queue functions.
>   */
>  #define QTAILQ_INIT(head) do {                                          \
>          (head)->tqh_first = NULL;                                       \
> -        (head)->tqh_last = &(head)->tqh_first;                          \
> +        (head)->tqh_circ.tql_prev = &(head)->tqh_circ;                  \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_INSERT_HEAD(head, elm, field) do {                       \
>          if (((elm)->field.tqe_next = (head)->tqh_first) != NULL)        \
> -                (head)->tqh_first->field.tqe_prev =                     \
> -                    &(elm)->field.tqe_next;                             \
> +            (head)->tqh_first->field.tqe_circ.tql_prev =                \
> +                &(elm)->field.tqe_circ;                                 \
>          else                                                            \
> -                (head)->tqh_last = &(elm)->field.tqe_next;              \
> +            (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;         \
>          (head)->tqh_first = (elm);                                      \
> -        (elm)->field.tqe_prev = &(head)->tqh_first;                     \
> +        (elm)->field.tqe_circ.tql_prev = &(head)->tqh_circ;             \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_INSERT_TAIL(head, elm, field) do {                       \
>          (elm)->field.tqe_next = NULL;                                   \
> -        (elm)->field.tqe_prev = (head)->tqh_last;                       \
> -        *(head)->tqh_last = (elm);                                      \
> -        (head)->tqh_last = &(elm)->field.tqe_next;                      \
> +        (elm)->field.tqe_circ.tql_prev = (head)->tqh_circ.tql_prev;     \
> +        (head)->tqh_circ.tql_prev->tql_next = (elm);                    \
> +        (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;             \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_INSERT_AFTER(head, listelm, elm, field) do {             \
>          if (((elm)->field.tqe_next = (listelm)->field.tqe_next) != NULL)\
> -                (elm)->field.tqe_next->field.tqe_prev =                 \
> -                    &(elm)->field.tqe_next;                             \
> +            (elm)->field.tqe_next->field.tqe_circ.tql_prev =            \
> +                &(elm)->field.tqe_circ;                                 \
>          else                                                            \
> -                (head)->tqh_last = &(elm)->field.tqe_next;              \
> +            (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;         \
>          (listelm)->field.tqe_next = (elm);                              \
> -        (elm)->field.tqe_prev = &(listelm)->field.tqe_next;             \
> +        (elm)->field.tqe_circ.tql_prev = &(listelm)->field.tqe_circ;    \
>  } while (/*CONSTCOND*/0)
>  
> -#define QTAILQ_INSERT_BEFORE(listelm, elm, field) do {                  \
> -        (elm)->field.tqe_prev = (listelm)->field.tqe_prev;              \
> -        (elm)->field.tqe_next = (listelm);                              \
> -        *(listelm)->field.tqe_prev = (elm);                             \
> -        (listelm)->field.tqe_prev = &(elm)->field.tqe_next;             \
> +#define QTAILQ_INSERT_BEFORE(listelm, elm, field) do {                       \
> +        (elm)->field.tqe_circ.tql_prev = (listelm)->field.tqe_circ.tql_prev; \
> +        (elm)->field.tqe_next = (listelm);                                   \
> +        (listelm)->field.tqe_circ.tql_prev->tql_next = (elm);                \
> +        (listelm)->field.tqe_circ.tql_prev = &(elm)->field.tqe_circ;         \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_REMOVE(head, elm, field) do {                            \
>          if (((elm)->field.tqe_next) != NULL)                            \
> -                (elm)->field.tqe_next->field.tqe_prev =                 \
> -                    (elm)->field.tqe_prev;                              \
> +            (elm)->field.tqe_next->field.tqe_circ.tql_prev =            \
> +                (elm)->field.tqe_circ.tql_prev;                         \
>          else                                                            \
> -                (head)->tqh_last = (elm)->field.tqe_prev;               \
> -        *(elm)->field.tqe_prev = (elm)->field.tqe_next;                 \
> -        (elm)->field.tqe_prev = NULL;                                   \
> +            (head)->tqh_circ.tql_prev = (elm)->field.tqe_circ.tql_prev; \
> +        (elm)->field.tqe_circ.tql_prev->tql_next = (elm)->field.tqe_next; \
> +        (elm)->field.tqe_circ.tql_prev = NULL;                          \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_FOREACH(var, head, field)                                \
> @@ -430,13 +433,13 @@ struct {                                                                \
>                  (var) = (next_var))
>  
>  #define QTAILQ_FOREACH_REVERSE(var, head, headname, field)              \
> -        for ((var) = (*(((struct headname *)((head)->tqh_last))->tqh_last));    \
> +        for ((var) = QTAILQ_LAST(head, headname);                       \
>                  (var);                                                  \
> -                (var) = (*(((struct headname *)((var)->field.tqe_prev))->tqh_last)))
> +                (var) = QTAILQ_PREV(var, headname, field))
>  
>  #define QTAILQ_FOREACH_REVERSE_SAFE(var, head, headname, field, prev_var) \
> -        for ((var) = (*(((struct headname *)((head)->tqh_last))->tqh_last)); \
> -             (var) && ((prev_var) = (*(((struct headname *)((var)->field.tqe_prev))->tqh_last)), 1); \
> +        for ((var) = QTAILQ_LAST(head, headname);                       \
> +             (var) && ((prev_var) = QTAILQ_PREV(var, headname, field)); \
>               (var) = (prev_var))
>  
>  /*
> @@ -445,71 +448,49 @@ struct {                                                                \
>  #define QTAILQ_EMPTY(head)               ((head)->tqh_first == NULL)
>  #define QTAILQ_FIRST(head)               ((head)->tqh_first)
>  #define QTAILQ_NEXT(elm, field)          ((elm)->field.tqe_next)
> -#define QTAILQ_IN_USE(elm, field)        ((elm)->field.tqe_prev != NULL)
> +#define QTAILQ_IN_USE(elm, field)        ((elm)->field.tqe_circ.tql_prev != NULL)
>  
> +#define QTAILQ_LINK_PREV(link)                                          \
> +        ((link).tql_prev->tql_prev->tql_next)
>  #define QTAILQ_LAST(head, headname) \
> -        (*(((struct headname *)((head)->tqh_last))->tqh_last))
> +        ((typeof((head)->tqh_first)) QTAILQ_LINK_PREV((head)->tqh_circ))
>  #define QTAILQ_PREV(elm, headname, field) \
> -        (*(((struct headname *)((elm)->field.tqe_prev))->tqh_last))
> +        ((typeof((elm)->field.tqe_next)) QTAILQ_LINK_PREV((elm)->field.tqe_circ))
>  
>  #define field_at_offset(base, offset, type)                                    \
> -        ((type) (((char *) (base)) + (offset)))
> -
> -typedef struct DUMMY_Q_ENTRY DUMMY_Q_ENTRY;
> -typedef struct DUMMY_Q DUMMY_Q;
> -
> -struct DUMMY_Q_ENTRY {
> -        QTAILQ_ENTRY(DUMMY_Q_ENTRY) next;
> -};
> -
> -struct DUMMY_Q {
> -        QTAILQ_HEAD(DUMMY_Q_HEAD, DUMMY_Q_ENTRY) head;
> -};
> -
> -#define dummy_q ((DUMMY_Q *) 0)
> -#define dummy_qe ((DUMMY_Q_ENTRY *) 0)
> +        ((type *) (((char *) (base)) + (offset)))
>  
>  /*
> - * Offsets of layout of a tail queue head.
> - */
> -#define QTAILQ_FIRST_OFFSET (offsetof(typeof(dummy_q->head), tqh_first))
> -#define QTAILQ_LAST_OFFSET  (offsetof(typeof(dummy_q->head), tqh_last))
> -/*
> - * Raw access of elements of a tail queue
> + * Raw access of elements of a tail queue head.  Offsets are all zero
> + * because it's a union.
>   */
>  #define QTAILQ_RAW_FIRST(head)                                                 \
> -        (*field_at_offset(head, QTAILQ_FIRST_OFFSET, void **))
> -#define QTAILQ_RAW_TQH_LAST(head)                                              \
> -        (*field_at_offset(head, QTAILQ_LAST_OFFSET, void ***))
> -
> -/*
> - * Offsets of layout of a tail queue element.
> - */
> -#define QTAILQ_NEXT_OFFSET (offsetof(typeof(dummy_qe->next), tqe_next))
> -#define QTAILQ_PREV_OFFSET (offsetof(typeof(dummy_qe->next), tqe_prev))
> +        field_at_offset(head, 0, void *)
> +#define QTAILQ_RAW_TQH_CIRC(head)                                              \
> +        field_at_offset(head, 0, QTailQLink)
>  
>  /*
>   * Raw access of elements of a tail entry
>   */
>  #define QTAILQ_RAW_NEXT(elm, entry)                                            \
> -        (*field_at_offset(elm, entry + QTAILQ_NEXT_OFFSET, void **))
> -#define QTAILQ_RAW_TQE_PREV(elm, entry)                                        \
> -        (*field_at_offset(elm, entry + QTAILQ_PREV_OFFSET, void ***))
> +        field_at_offset(elm, entry, void *)
> +#define QTAILQ_RAW_TQE_CIRC(elm, entry)                                        \
> +        field_at_offset(elm, entry, QTailQLink)
>  /*
> - * Tail queue tranversal using pointer arithmetic.
> + * Tail queue traversal using pointer arithmetic.
>   */
>  #define QTAILQ_RAW_FOREACH(elm, head, entry)                                   \
> -        for ((elm) = QTAILQ_RAW_FIRST(head);                                   \
> +        for ((elm) = *QTAILQ_RAW_FIRST(head);                                  \
>               (elm);                                                            \
> -             (elm) = QTAILQ_RAW_NEXT(elm, entry))
> +             (elm) = *QTAILQ_RAW_NEXT(elm, entry))
>  /*
>   * Tail queue insertion using pointer arithmetic.
>   */
> -#define QTAILQ_RAW_INSERT_TAIL(head, elm, entry) do {                          \
> -        QTAILQ_RAW_NEXT(elm, entry) = NULL;                                    \
> -        QTAILQ_RAW_TQE_PREV(elm, entry) = QTAILQ_RAW_TQH_LAST(head);           \
> -        *QTAILQ_RAW_TQH_LAST(head) = (elm);                                    \
> -        QTAILQ_RAW_TQH_LAST(head) = &QTAILQ_RAW_NEXT(elm, entry);              \
> +#define QTAILQ_RAW_INSERT_TAIL(head, elm, entry) do {                           \
> +        *QTAILQ_RAW_NEXT(elm, entry) = NULL;                                    \
> +        QTAILQ_RAW_TQE_CIRC(elm, entry)->tql_prev = QTAILQ_RAW_TQH_CIRC(head)->tql_prev; \
> +        QTAILQ_RAW_TQH_CIRC(head)->tql_prev->tql_next = (elm);                  \
> +        QTAILQ_RAW_TQH_CIRC(head)->tql_prev = QTAILQ_RAW_TQE_CIRC(elm, entry);  \
>  } while (/*CONSTCOND*/0)
>  
>  #endif /* QEMU_SYS_QUEUE_H */
> diff --git a/include/qemu/rcu_queue.h b/include/qemu/rcu_queue.h
> index 904b3372dc..2bee5dff80 100644
> --- a/include/qemu/rcu_queue.h
> +++ b/include/qemu/rcu_queue.h
> @@ -206,47 +206,50 @@ extern "C" {
>  #define QTAILQ_INSERT_HEAD_RCU(head, elm, field) do {                   \
>      (elm)->field.tqe_next = (head)->tqh_first;                          \
>      if ((elm)->field.tqe_next != NULL) {                                \
> -        (head)->tqh_first->field.tqe_prev = &(elm)->field.tqe_next;     \
> +        (head)->tqh_first->field.tqe_circ.tql_prev =                    \
> +            &(elm)->field.tqe_circ;                                     \
>      } else {                                                            \
> -        (head)->tqh_last = &(elm)->field.tqe_next;                      \
> +        (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;             \
>      }                                                                   \
>      atomic_rcu_set(&(head)->tqh_first, (elm));                          \
> -    (elm)->field.tqe_prev = &(head)->tqh_first;                         \
> +    (elm)->field.tqe_circ.tql_prev = &(head)->tqh_circ;                 \
>  } while (/*CONSTCOND*/0)
>  
> -#define QTAILQ_INSERT_TAIL_RCU(head, elm, field) do {               \
> -    (elm)->field.tqe_next = NULL;                                   \
> -    (elm)->field.tqe_prev = (head)->tqh_last;                       \
> -    atomic_rcu_set((head)->tqh_last, (elm));                        \
> -    (head)->tqh_last = &(elm)->field.tqe_next;                      \
> +#define QTAILQ_INSERT_TAIL_RCU(head, elm, field) do {                   \
> +    (elm)->field.tqe_next = NULL;                                       \
> +    (elm)->field.tqe_circ.tql_prev = (head)->tqh_circ.tql_prev;         \
> +    atomic_rcu_set(&(head)->tqh_circ.tql_prev->tql_next, (elm));        \
> +    (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;                 \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_INSERT_AFTER_RCU(head, listelm, elm, field) do {         \
>      (elm)->field.tqe_next = (listelm)->field.tqe_next;                  \
>      if ((elm)->field.tqe_next != NULL) {                                \
> -        (elm)->field.tqe_next->field.tqe_prev = &(elm)->field.tqe_next; \
> +        (elm)->field.tqe_next->field.tqe_circ.tql_prev =                \
> +            &(elm)->field.tqe_circ;                                     \
>      } else {                                                            \
> -        (head)->tqh_last = &(elm)->field.tqe_next;                      \
> +        (head)->tqh_circ.tql_prev = &(elm)->field.tqe_circ;             \
>      }                                                                   \
>      atomic_rcu_set(&(listelm)->field.tqe_next, (elm));                  \
> -    (elm)->field.tqe_prev = &(listelm)->field.tqe_next;                 \
> +    (elm)->field.tqe_circ.tql_prev = &(listelm)->field.tqe_circ;        \
>  } while (/*CONSTCOND*/0)
>  
> -#define QTAILQ_INSERT_BEFORE_RCU(listelm, elm, field) do {          \
> -    (elm)->field.tqe_prev = (listelm)->field.tqe_prev;              \
> -    (elm)->field.tqe_next = (listelm);                              \
> -    atomic_rcu_set((listelm)->field.tqe_prev, (elm));               \
> -    (listelm)->field.tqe_prev = &(elm)->field.tqe_next;             \
> -    } while (/*CONSTCOND*/0)
> +#define QTAILQ_INSERT_BEFORE_RCU(listelm, elm, field) do {                \
> +    (elm)->field.tqe_circ.tql_prev = (listelm)->field.tqe_circ.tql_prev;  \
> +    (elm)->field.tqe_next = (listelm);                                    \
> +    atomic_rcu_set(&(listelm)->field.tqe_circ.tql_prev->tql_next, (elm)); \
> +    (listelm)->field.tqe_circ.tql_prev = &(elm)->field.tqe_circ;          \
> +} while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_REMOVE_RCU(head, elm, field) do {                        \
>      if (((elm)->field.tqe_next) != NULL) {                              \
> -        (elm)->field.tqe_next->field.tqe_prev = (elm)->field.tqe_prev;  \
> +        (elm)->field.tqe_next->field.tqe_circ.tql_prev =                \
> +            (elm)->field.tqe_circ.tql_prev;                             \
>      } else {                                                            \
> -        (head)->tqh_last = (elm)->field.tqe_prev;                       \
> +        (head)->tqh_circ.tql_prev = (elm)->field.tqe_circ.tql_prev;     \
>      }                                                                   \
> -    atomic_set((elm)->field.tqe_prev, (elm)->field.tqe_next);           \
> -    (elm)->field.tqe_prev = NULL;                                       \
> +    atomic_set(&(elm)->field.tqe_circ.tql_prev->tql_next, (elm)->field.tqe_next); \
> +    (elm)->field.tqe_circ.tql_prev = NULL;                              \
>  } while (/*CONSTCOND*/0)
>  
>  #define QTAILQ_FOREACH_RCU(var, head, field)                            \
> diff --git a/scripts/cocci-macro-file.h b/scripts/cocci-macro-file.h
> index 9f2e72e7e1..7f1006e97c 100644
> --- a/scripts/cocci-macro-file.h
> +++ b/scripts/cocci-macro-file.h
> @@ -93,29 +93,19 @@ struct {                                                                \
>  /*
>   * Tail queue definitions.
>   */
> -#define Q_TAILQ_HEAD(name, type, qual)                                  \
> -struct name {                                                           \
> -        qual type *tqh_first;           /* first element */             \
> -        qual type *qual *tqh_last;      /* addr of last next element */ \
> -}
>  #define QTAILQ_HEAD(name, type)                                         \
> -struct name {                                                           \
> -        type *tqh_first;      /* first element */                       \
> -        type **tqh_last;      /* addr of last next element */           \
> +union name {                                                            \
> +        struct type *tqh_first;       /* first element */               \
> +        QTailQLink tqh_circ;          /* link for last element */       \
>  }
>  
>  #define QTAILQ_HEAD_INITIALIZER(head)                                   \
> -        { NULL, &(head).tqh_first }
> +        { .tqh_circ = { NULL, &(head).tqh_circ } }
>  
> -#define Q_TAILQ_ENTRY(type, qual)                                       \
> -struct {                                                                \
> -        qual type *tqe_next;            /* next element */              \
> -        qual type *qual *tqe_prev;      /* address of previous next element */\
> -}
>  #define QTAILQ_ENTRY(type)                                              \
> -struct {                                                                \
> -        type *tqe_next;       /* next element */                        \
> -        type **tqe_prev;      /* address of previous next element */    \
> +union {                                                                 \
> +        struct type *tqe_next;        /* next element */                \
> +        QTailQLink tqe_circ;          /* link for prev element */       \
>  }
>  
>  /* From glib */
