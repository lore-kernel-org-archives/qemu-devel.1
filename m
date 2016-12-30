Received: from eggs.gnu.org ([2001:4830:134:3::10]:40447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMykB-0000h8-Tv
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1cMyk8-00015B-3e
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:05:19 -0500
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Fri, 30 Dec 2016 17:31:26 +0300
Message-ID: <20161230143142.18214-3-pbutsykin@virtuozzo.com>
In-Reply-To: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
References: <20161230143142.18214-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 02/18] util/rbtree: add rbtree from linux
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, armbru@redhat.com

Why don't we use rbtree from glib? We need  pointer to the parent node.
For optimal implementation storing of cached chunks in the rbtree need to
get next and previous nodes and content of parent node is very useful for
effective implementation of these functions. In this implementation of
rbtree (unlike rbtree of glib) the node contains a pointer to parent node.
Moreover, this rbtree allows more flexibility to work with an algorithm
because to use rbtrees you'll have to implement your own insert and search
cores. This will avoid us to use callbacks and to drop drammatically
performances.

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 MAINTAINERS                     |   7 +
 include/qemu/rbtree.h           | 107 ++++++++
 include/qemu/rbtree_augmented.h | 235 +++++++++++++++++
 util/Makefile.objs              |   1 +
 util/rbtree.c                   | 570 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 920 insertions(+)
 create mode 100644 include/qemu/rbtree.h
 create mode 100644 include/qemu/rbtree_augmented.h
 create mode 100644 util/rbtree.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 585cd5abd7..228278c1ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1465,6 +1465,13 @@ F: include/qemu/throttle.h
 F: util/throttle.c
 L: qemu-block@nongnu.org
 
+Red Black Trees
+M: Denis V. Lunev <den@openvz.org>
+S: Supported
+F: include/qemu/rbtree.h
+F: include/qemu/rbtree_augmented.h
+F: util/rbtree.c
+
 UUID
 M: Fam Zheng <famz@redhat.com>
 S: Supported
diff --git a/include/qemu/rbtree.h b/include/qemu/rbtree.h
new file mode 100644
index 0000000000..d2e3fdd149
--- /dev/null
+++ b/include/qemu/rbtree.h
@@ -0,0 +1,107 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  include/qemu/rbtree.h
+
+  To use rbtrees you'll have to implement your own insert and search cores.
+  This will avoid us to use callbacks and to drop drammatically performances.
+  I know it's not the cleaner way,  but in C (not in C++) to get
+  performances and genericity...
+*/
+
+#ifndef QEMU_RBTREE_H
+#define QEMU_RBTREE_H
+
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+
+struct RbNode {
+    uintptr_t __rb_parent_color;
+    struct RbNode *rb_right;
+    struct RbNode *rb_left;
+} __attribute__((aligned(sizeof(uintptr_t))));
+    /* The alignment might seem pointless, but allegedly CRIS needs it */
+
+struct RbRoot {
+    struct RbNode *rb_node;
+};
+
+
+#define RB_PARENT(r) ((struct RbNode *)((r)->__rb_parent_color & ~3))
+
+#define RB_ROOT (struct RbRoot) { NULL, }
+#define RB_ENTRY(ptr, type, member) container_of(ptr, type, member)
+
+#define RB_EMPTY_ROOT(root) ((root)->rb_node == NULL)
+
+/* 'empty' nodes are nodes that are known not to be inserted in an rbtree */
+#define RB_EMPTY_NODE(node)  \
+    ((node)->__rb_parent_color == (uintptr_t)(node))
+#define RB_CLEAR_NODE(node)  \
+    ((node)->__rb_parent_color = (uintptr_t)(node))
+
+
+extern void rb_insert_color(struct RbNode *, struct RbRoot *);
+extern void rb_erase(struct RbNode *, struct RbRoot *);
+
+
+/* Find logical next and previous nodes in a tree */
+extern struct RbNode *rb_next(const struct RbNode *);
+extern struct RbNode *rb_prev(const struct RbNode *);
+extern struct RbNode *rb_first(const struct RbRoot *);
+extern struct RbNode *rb_last(const struct RbRoot *);
+
+/* Postorder iteration - always visit the parent after its children */
+extern struct RbNode *rb_first_postorder(const struct RbRoot *);
+extern struct RbNode *rb_next_postorder(const struct RbNode *);
+
+/* Fast replacement of a single node without remove/rebalance/add/rebalance */
+extern void rb_replace_node(struct RbNode *victim, struct RbNode *new,
+                            struct RbRoot *root);
+
+static inline void rb_link_node(struct RbNode *node, struct RbNode *parent,
+                                struct RbNode **rb_link)
+{
+    node->__rb_parent_color = (uintptr_t)parent;
+    node->rb_left = node->rb_right = NULL;
+
+    *rb_link = node;
+}
+
+#define RB_ENTRY_SAFE(ptr, type, member)                 \
+    ({ typeof(ptr) ____ptr = (ptr);                      \
+       ____ptr ? rb_entry(____ptr, type, member) : NULL; \
+    })
+
+/**
+ * rbtree_postorder_for_each_entry_safe - iterate over rb_root in post order of
+ * given type safe against removal of rb_node entry
+ *
+ * @pos:   the 'type *' to use as a loop cursor.
+ * @n:     another 'type *' to use as temporary storage
+ * @root:  'rb_root *' of the rbtree.
+ * @field: the name of the rb_node field within 'type'.
+ */
+#define RBTREE_POSTORDER_FOR_EACH_ENTRY_SAFE(pos, n, root, field)            \
+    for (pos = rb_entry_safe(rb_first_postorder(root), typeof(*pos), field); \
+         pos && ({ n = rb_entry_safe(rb_next_postorder(&pos->field),         \
+         typeof(*pos), field); 1; });                                        \
+         pos = n)
+
+#endif  /* QEMU_RBTREE_H */
diff --git a/include/qemu/rbtree_augmented.h b/include/qemu/rbtree_augmented.h
new file mode 100644
index 0000000000..f218d31e96
--- /dev/null
+++ b/include/qemu/rbtree_augmented.h
@@ -0,0 +1,235 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  (C) 2002  David Woodhouse <dwmw2@infradead.org>
+  (C) 2012  Michel Lespinasse <walken@google.com>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+  include/qemu/rbtree_augmented.h
+*/
+
+#ifndef QEMU_RBTREE_AUGMENTED_H
+#define QEMU_RBTREE_AUGMENTED_H
+
+#include "qemu/compiler.h"
+#include "qemu/rbtree.h"
+
+/*
+ * Please note - only struct RbAugmentCallbacks and the prototypes for
+ * rb_insert_augmented() and rb_erase_augmented() are intended to be public.
+ * The rest are implementation details you are not expected to depend on.
+ */
+
+struct RbAugmentCallbacks {
+    void (*propagate)(struct RbNode *node, struct RbNode *stop);
+    void (*copy)(struct RbNode *old, struct RbNode *new);
+    void (*rotate)(struct RbNode *old, struct RbNode *new);
+};
+
+extern void __rb_insert_augmented(struct RbNode *node, struct RbRoot *root,
+    void (*augment_rotate)(struct RbNode *old, struct RbNode *new));
+/*
+ * Fixup the rbtree and update the augmented information when rebalancing.
+ *
+ * On insertion, the user must update the augmented information on the path
+ * leading to the inserted node, then call rb_link_node() as usual and
+ * rb_augment_inserted() instead of the usual rb_insert_color() call.
+ * If rb_augment_inserted() rebalances the rbtree, it will callback into
+ * a user provided function to update the augmented information on the
+ * affected subtrees.
+ */
+static inline void
+rb_insert_augmented(struct RbNode *node, struct RbRoot *root,
+                    const struct RbAugmentCallbacks *augment)
+{
+    __rb_insert_augmented(node, root, augment->rotate);
+}
+
+#define RB_DECLARE_CALLBACKS(rbstatic, rbname, rbstruct, rbfield, \
+                             rbtype, rbaugmented, rbcompute)      \
+static inline void                                                \
+rbname ## _propagate(struct RbNode *rb, struct RbNode *stop)      \
+{                                                                 \
+    while (rb != stop) {                                          \
+        rbstruct *node = rb_entry(rb, rbstruct, rbfield);         \
+        rbtype augmented = rbcompute(node);                       \
+        if (node->rbaugmented == augmented) {                     \
+            break;                                                \
+        }                                                         \
+        node->rbaugmented = augmented;                            \
+        rb = rb_parent(&node->rbfield);                           \
+    }                                                             \
+}                                                                 \
+static inline void                                                \
+rbname ## _copy(struct RbNode *rb_old, struct RbNode *rb_new)     \
+{                                                                 \
+    rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);          \
+    rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);          \
+    new->rbaugmented = old->rbaugmented;                          \
+}                                                                 \
+static void                                                       \
+rbname ## _rotate(struct RbNode *rb_old, struct RbNode *rb_new)   \
+{                                                                 \
+    rbstruct *old = rb_entry(rb_old, rbstruct, rbfield);          \
+    rbstruct *new = rb_entry(rb_new, rbstruct, rbfield);          \
+    new->rbaugmented = old->rbaugmented;                          \
+    old->rbaugmented = rbcompute(old);                            \
+}                                                                 \
+rbstatic const struct RbAugmentCallbacks rbname = {               \
+    rbname ## _propagate, rbname ## _copy, rbname ## _rotate      \
+};
+
+
+#define RB_RED   0
+#define RB_BLACK 1
+
+#define __RB_PARENT(pc)    ((struct RbNode *)(pc & ~3))
+
+#define __RB_COLOR(pc)     ((pc) & 1)
+#define __RB_IS_BLACK(pc)  __RB_COLOR(pc)
+#define __RB_IS_RED(pc)    (!__RB_COLOR(pc))
+#define RB_COLOR(rb)       __RB_COLOR((rb)->__rb_parent_color)
+#define RB_IS_RED(rb)      __RB_IS_RED((rb)->__rb_parent_color)
+#define RB_IS_BLACK(rb)    __RB_IS_BLACK((rb)->__rb_parent_color)
+
+static inline void rb_set_parent(struct RbNode *rb, struct RbNode *p)
+{
+    rb->__rb_parent_color = RB_COLOR(rb) | (uintptr_t)p;
+}
+
+static inline void rb_set_parent_color(struct RbNode *rb,
+                                       struct RbNode *p, int color)
+{
+    rb->__rb_parent_color = (uintptr_t)p | color;
+}
+
+static inline void
+__rb_change_child(struct RbNode *old, struct RbNode *new,
+                  struct RbNode *parent, struct RbRoot *root)
+{
+    if (parent) {
+        if (parent->rb_left == old) {
+            parent->rb_left = new;
+        } else {
+            parent->rb_right = new;
+        }
+    } else {
+        root->rb_node = new;
+    }
+}
+
+extern void __rb_erase_color(struct RbNode *parent, struct RbRoot *root,
+    void (*augment_rotate)(struct RbNode *old, struct RbNode *new));
+
+static inline struct RbNode *
+__rb_erase_augmented(struct RbNode *node, struct RbRoot *root,
+                     const struct RbAugmentCallbacks *augment)
+{
+    struct RbNode *child = node->rb_right, *tmp = node->rb_left;
+    struct RbNode *parent, *rebalance;
+    uintptr_t pc;
+
+    if (!tmp) {
+        /*
+         * Case 1: node to erase has no more than 1 child (easy!)
+         *
+         * Note that if there is one child it must be red due to 5)
+         * and node must be black due to 4). We adjust colors locally
+         * so as to bypass __rb_erase_color() later on.
+         */
+        pc = node->__rb_parent_color;
+        parent = __RB_PARENT(pc);
+        __rb_change_child(node, child, parent, root);
+        if (child) {
+            child->__rb_parent_color = pc;
+            rebalance = NULL;
+        } else {
+            rebalance = __RB_IS_BLACK(pc) ? parent : NULL;
+        }
+        tmp = parent;
+    } else if (!child) {
+        /* Still case 1, but this time the child is node->rb_left */
+        tmp->__rb_parent_color = pc = node->__rb_parent_color;
+        parent = __RB_PARENT(pc);
+        __rb_change_child(node, tmp, parent, root);
+        rebalance = NULL;
+        tmp = parent;
+    } else {
+        struct RbNode *successor = child, *child2;
+        tmp = child->rb_left;
+        if (!tmp) {
+            /*
+             * Case 2: node's successor is its right child
+             *
+             *    (n)          (s)
+             *    / \          / \
+             *  (x) (s)  ->  (x) (c)
+             *        \
+             *        (c)
+             */
+            parent = successor;
+            child2 = successor->rb_right;
+            augment->copy(node, successor);
+        } else {
+            /*
+             * Case 3: node's successor is leftmost under
+             * node's right child subtree
+             *
+             *    (n)          (s)
+             *    / \          / \
+             *  (x) (y)  ->  (x) (y)
+             *      /            /
+             *    (p)          (p)
+             *    /            /
+             *  (s)          (c)
+             *    \
+             *    (c)
+             */
+            do {
+                parent = successor;
+                successor = tmp;
+                tmp = tmp->rb_left;
+            } while (tmp);
+            parent->rb_left = child2 = successor->rb_right;
+            successor->rb_right = child;
+            rb_set_parent(child, successor);
+            augment->copy(node, successor);
+            augment->propagate(parent, successor);
+        }
+
+        successor->rb_left = tmp = node->rb_left;
+        rb_set_parent(tmp, successor);
+
+        pc = node->__rb_parent_color;
+        tmp = __RB_PARENT(pc);
+        __rb_change_child(node, successor, tmp, root);
+        if (child2) {
+            successor->__rb_parent_color = pc;
+            rb_set_parent_color(child2, parent, RB_BLACK);
+            rebalance = NULL;
+        } else {
+            unsigned long pc2 = successor->__rb_parent_color;
+            successor->__rb_parent_color = pc;
+            rebalance = __RB_IS_BLACK(pc2) ? parent : NULL;
+        }
+        tmp = successor;
+    }
+
+    augment->propagate(tmp, NULL);
+    return rebalance;
+}
+
+#endif /* QEMU_RBTREE_AUGMENTED_H */
diff --git a/util/Makefile.objs b/util/Makefile.objs
index ad0f9c7fe4..a5607cb88f 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -36,3 +36,4 @@ util-obj-y += log.o
 util-obj-y += qdist.o
 util-obj-y += qht.o
 util-obj-y += range.o
+util-obj-y += rbtree.o
diff --git a/util/rbtree.c b/util/rbtree.c
new file mode 100644
index 0000000000..704dcea60a
--- /dev/null
+++ b/util/rbtree.c
@@ -0,0 +1,570 @@
+/*
+  Red Black Trees
+  (C) 1999  Andrea Arcangeli <andrea@suse.de>
+  (C) 2002  David Woodhouse <dwmw2@infradead.org>
+  (C) 2012  Michel Lespinasse <walken@google.com>
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation; either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program; if not, write to the Free Software
+  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+#include "qemu/rbtree_augmented.h"
+
+/*
+ * red-black trees properties:  http://en.wikipedia.org/wiki/Rbtree
+ *
+ *  1) A node is either red or black
+ *  2) The root is black
+ *  3) All leaves (NULL) are black
+ *  4) Both children of every red node are black
+ *  5) Every simple path from root to leaves contains the same number
+ *     of black nodes.
+ *
+ *  4 and 5 give the O(log n) guarantee, since 4 implies you cannot have two
+ *  consecutive red nodes in a path and every red node is therefore followed by
+ *  a black. So if B is the number of black nodes on every simple path (as per
+ *  5), then the longest possible path due to 4 is 2B.
+ *
+ *  We shall indicate color with case, where black nodes are uppercase and red
+ *  nodes will be lowercase. Unknown color nodes shall be drawn as red within
+ *  parentheses and have some accompanying text comment.
+ */
+
+static inline void rb_set_black(struct RbNode *rb)
+{
+    rb->__rb_parent_color |= RB_BLACK;
+}
+
+static inline struct RbNode *rb_red_parent(struct RbNode *red)
+{
+    return (struct RbNode *)red->__rb_parent_color;
+}
+
+/*
+ * Helper function for rotations:
+ * - old's parent and color get assigned to new
+ * - old gets assigned new as a parent and 'color' as a color.
+ */
+static inline void
+__rb_rotate_set_parents(struct RbNode *old, struct RbNode *new,
+                        struct RbRoot *root, int color)
+{
+    struct RbNode *parent = RB_PARENT(old);
+    new->__rb_parent_color = old->__rb_parent_color;
+    rb_set_parent_color(old, new, color);
+    __rb_change_child(old, new, parent, root);
+}
+
+static inline void
+__rb_insert(struct RbNode *node, struct RbRoot *root,
+            void (*augment_rotate)(struct RbNode *old, struct RbNode *new))
+{
+    struct RbNode *parent = rb_red_parent(node), *gparent, *tmp;
+
+    while (true) {
+        /*
+        * Loop invariant: node is red
+        *
+        * If there is a black parent, we are done.
+        * Otherwise, take some corrective action as we don't
+        * want a red root or two consecutive red nodes.
+        */
+        if (!parent) {
+            rb_set_parent_color(node, NULL, RB_BLACK);
+            break;
+        } else if (RB_IS_BLACK(parent)) {
+            break;
+        }
+
+        gparent = rb_red_parent(parent);
+
+        tmp = gparent->rb_right;
+        if (parent != tmp) {    /* parent == gparent->rb_left */
+            if (tmp && RB_IS_RED(tmp)) {
+                /*
+                 * Case 1 - color flips
+                 *
+                 *       G            g
+                 *      / \          / \
+                 *     p   u  -->   P   U
+                 *    /            /
+                 *   n            n
+                 *
+                 * However, since g's parent might be red, and
+                 * 4) does not allow this, we need to recurse
+                 * at g.
+                 */
+                rb_set_parent_color(tmp, gparent, RB_BLACK);
+                rb_set_parent_color(parent, gparent, RB_BLACK);
+                node = gparent;
+                parent = RB_PARENT(node);
+                rb_set_parent_color(node, parent, RB_RED);
+                continue;
+            }
+
+            tmp = parent->rb_right;
+            if (node == tmp) {
+                /*
+                 * Case 2 - left rotate at parent
+                 *
+                 *      G             G
+                 *     / \           / \
+                 *    p   U  -->    n   U
+                 *     \           /
+                 *      n         p
+                 *
+                 * This still leaves us in violation of 4), the
+                 * continuation into Case 3 will fix that.
+                 */
+                parent->rb_right = tmp = node->rb_left;
+                node->rb_left = parent;
+                if (tmp) {
+                    rb_set_parent_color(tmp, parent, RB_BLACK);
+                }
+                rb_set_parent_color(parent, node, RB_RED);
+                augment_rotate(parent, node);
+                parent = node;
+                tmp = node->rb_right;
+            }
+
+            /*
+             * Case 3 - right rotate at gparent
+             *
+             *        G           P
+             *       / \         / \
+             *      p   U  -->  n   g
+             *     /                 \
+             *    n                   U
+             */
+            gparent->rb_left = tmp;  /* == parent->rb_right */
+            parent->rb_right = gparent;
+            if (tmp) {
+                rb_set_parent_color(tmp, gparent, RB_BLACK);
+            }
+            __rb_rotate_set_parents(gparent, parent, root, RB_RED);
+            augment_rotate(gparent, parent);
+            break;
+        } else {
+            tmp = gparent->rb_left;
+            if (tmp && RB_IS_RED(tmp)) {
+                /* Case 1 - color flips */
+                rb_set_parent_color(tmp, gparent, RB_BLACK);
+                rb_set_parent_color(parent, gparent, RB_BLACK);
+                node = gparent;
+                parent = RB_PARENT(node);
+                rb_set_parent_color(node, parent, RB_RED);
+                continue;
+            }
+
+            tmp = parent->rb_left;
+            if (node == tmp) {
+                /* Case 2 - right rotate at parent */
+                parent->rb_left = tmp = node->rb_right;
+                node->rb_right = parent;
+                if (tmp) {
+                    rb_set_parent_color(tmp, parent, RB_BLACK);
+                }
+                rb_set_parent_color(parent, node, RB_RED);
+                augment_rotate(parent, node);
+                parent = node;
+                tmp = node->rb_left;
+            }
+
+            /* Case 3 - left rotate at gparent */
+            gparent->rb_right = tmp;  /* == parent->rb_left */
+            parent->rb_left = gparent;
+            if (tmp) {
+                rb_set_parent_color(tmp, gparent, RB_BLACK);
+            }
+            __rb_rotate_set_parents(gparent, parent, root, RB_RED);
+            augment_rotate(gparent, parent);
+            break;
+        }
+    }
+}
+
+/*
+ * Inline version for rb_erase() use - we want to be able to inline
+ * and eliminate the dummy_rotate callback there
+ */
+static inline void
+____rb_erase_color(struct RbNode *parent, struct RbRoot *root,
+                   void (*augment_rotate)(struct RbNode *old,
+                                          struct RbNode *new))
+{
+    struct RbNode *node = NULL, *sibling, *tmp1, *tmp2;
+
+    while (true) {
+        /*
+         * Loop invariants:
+         * - node is black (or NULL on first iteration)
+         * - node is not the root (parent is not NULL)
+         * - All leaf paths going through parent and node have a
+         *   black node count that is 1 lower than other leaf paths.
+         */
+        sibling = parent->rb_right;
+        if (node != sibling) {    /* node == parent->rb_left */
+            if (RB_IS_RED(sibling)) {
+                /*
+                 * Case 1 - left rotate at parent
+                 *
+                 *     P               S
+                 *    / \             / \
+                 *   N   s    -->    p   Sr
+                 *      / \         / \
+                 *     Sl  Sr      N   Sl
+                 */
+                parent->rb_right = tmp1 = sibling->rb_left;
+                sibling->rb_left = parent;
+                rb_set_parent_color(tmp1, parent, RB_BLACK);
+                __rb_rotate_set_parents(parent, sibling, root,
+                            RB_RED);
+                augment_rotate(parent, sibling);
+                sibling = tmp1;
+            }
+            tmp1 = sibling->rb_right;
+            if (!tmp1 || RB_IS_BLACK(tmp1)) {
+                tmp2 = sibling->rb_left;
+                if (!tmp2 || RB_IS_BLACK(tmp2)) {
+                    /*
+                     * Case 2 - sibling color flip
+                     * (p could be either color here)
+                     *
+                     *    (p)           (p)
+                     *    / \           / \
+                     *   N   S    -->  N   s
+                     *      / \           / \
+                     *     Sl  Sr        Sl  Sr
+                     *
+                     * This leaves us violating 5) which
+                     * can be fixed by flipping p to black
+                     * if it was red, or by recursing at p.
+                     * p is red when coming from Case 1.
+                     */
+                    rb_set_parent_color(sibling, parent,
+                                RB_RED);
+                    if (RB_IS_RED(parent)) {
+                        rb_set_black(parent);
+                    } else {
+                        node = parent;
+                        parent = RB_PARENT(node);
+                        if (parent) {
+                            continue;
+                        }
+                    }
+                    break;
+                }
+                /*
+                 * Case 3 - right rotate at sibling
+                 * (p could be either color here)
+                 *
+                 *   (p)           (p)
+                 *   / \           / \
+                 *  N   S    -->  N   Sl
+                 *     / \             \
+                 *    sl  Sr            s
+                 *                       \
+                 *                        Sr
+                 */
+                sibling->rb_left = tmp1 = tmp2->rb_right;
+                tmp2->rb_right = sibling;
+                parent->rb_right = tmp2;
+                if (tmp1) {
+                    rb_set_parent_color(tmp1, sibling, RB_BLACK);
+                }
+                augment_rotate(sibling, tmp2);
+                tmp1 = sibling;
+                sibling = tmp2;
+            }
+            /*
+             * Case 4 - left rotate at parent + color flips
+             * (p and sl could be either color here.
+             *  After rotation, p becomes black, s acquires
+             *  p's color, and sl keeps its color)
+             *
+             *      (p)             (s)
+             *      / \             / \
+             *     N   S     -->   P   Sr
+             *        / \         / \
+             *      (sl) sr      N  (sl)
+             */
+            parent->rb_right = tmp2 = sibling->rb_left;
+            sibling->rb_left = parent;
+            rb_set_parent_color(tmp1, sibling, RB_BLACK);
+            if (tmp2) {
+                rb_set_parent(tmp2, parent);
+            }
+            __rb_rotate_set_parents(parent, sibling, root,
+                        RB_BLACK);
+            augment_rotate(parent, sibling);
+            break;
+        } else {
+            sibling = parent->rb_left;
+            if (RB_IS_RED(sibling)) {
+                /* Case 1 - right rotate at parent */
+                parent->rb_left = tmp1 = sibling->rb_right;
+                sibling->rb_right = parent;
+                rb_set_parent_color(tmp1, parent, RB_BLACK);
+                __rb_rotate_set_parents(parent, sibling, root,
+                            RB_RED);
+                augment_rotate(parent, sibling);
+                sibling = tmp1;
+            }
+            tmp1 = sibling->rb_left;
+            if (!tmp1 || RB_IS_BLACK(tmp1)) {
+                tmp2 = sibling->rb_right;
+                if (!tmp2 || RB_IS_BLACK(tmp2)) {
+                    /* Case 2 - sibling color flip */
+                    rb_set_parent_color(sibling, parent,
+                                RB_RED);
+                    if (RB_IS_RED(parent)) {
+                        rb_set_black(parent);
+                    } else {
+                        node = parent;
+                        parent = RB_PARENT(node);
+                        if (parent) {
+                            continue;
+                        }
+                    }
+                    break;
+                }
+                /* Case 3 - right rotate at sibling */
+                sibling->rb_right = tmp1 = tmp2->rb_left;
+                tmp2->rb_left = sibling;
+                parent->rb_left = tmp2;
+                if (tmp1) {
+                    rb_set_parent_color(tmp1, sibling,
+                                RB_BLACK);
+                }
+                augment_rotate(sibling, tmp2);
+                tmp1 = sibling;
+                sibling = tmp2;
+            }
+            /* Case 4 - left rotate at parent + color flips */
+            parent->rb_left = tmp2 = sibling->rb_right;
+            sibling->rb_right = parent;
+            rb_set_parent_color(tmp1, sibling, RB_BLACK);
+            if (tmp2) {
+                rb_set_parent(tmp2, parent);
+            }
+            __rb_rotate_set_parents(parent, sibling, root,
+                        RB_BLACK);
+            augment_rotate(parent, sibling);
+            break;
+        }
+    }
+}
+
+/* Non-inline version for rb_erase_augmented() use */
+void __rb_erase_color(struct RbNode *parent, struct RbRoot *root,
+                      void (*augment_rotate)(struct RbNode *old,
+                                             struct RbNode *new))
+{
+    ____rb_erase_color(parent, root, augment_rotate);
+}
+
+/*
+ * Non-augmented rbtree manipulation functions.
+ *
+ * We use dummy augmented callbacks here, and have the compiler optimize them
+ * out of the rb_insert_color() and rb_erase() function definitions.
+ */
+
+static inline void dummy_propagate(struct RbNode *node, struct RbNode *stop) {}
+static inline void dummy_copy(struct RbNode *old, struct RbNode *new) {}
+static inline void dummy_rotate(struct RbNode *old, struct RbNode *new) {}
+
+static const struct RbAugmentCallbacks dummy_callbacks = {
+    dummy_propagate, dummy_copy, dummy_rotate
+};
+
+void rb_insert_color(struct RbNode *node, struct RbRoot *root)
+{
+    __rb_insert(node, root, dummy_rotate);
+}
+
+void rb_erase(struct RbNode *node, struct RbRoot *root)
+{
+    struct RbNode *rebalance;
+    rebalance = __rb_erase_augmented(node, root, &dummy_callbacks);
+    if (rebalance) {
+        ____rb_erase_color(rebalance, root, dummy_rotate);
+    }
+}
+
+/*
+ * Augmented rbtree manipulation functions.
+ *
+ * This instantiates the same __always_inline functions as in the non-augmented
+ * case, but this time with user-defined callbacks.
+ */
+
+void __rb_insert_augmented(struct RbNode *node, struct RbRoot *root,
+                           void (*augment_rotate)(struct RbNode *old,
+                                                  struct RbNode *new))
+{
+    __rb_insert(node, root, augment_rotate);
+}
+
+/*
+ * This function returns the first node (in sort order) of the tree.
+ */
+struct RbNode *rb_first(const struct RbRoot *root)
+{
+    struct RbNode    *n;
+
+    n = root->rb_node;
+    if (!n) {
+        return NULL;
+    }
+    while (n->rb_left) {
+        n = n->rb_left;
+    }
+    return n;
+}
+
+struct RbNode *rb_last(const struct RbRoot *root)
+{
+    struct RbNode    *n;
+
+    n = root->rb_node;
+    if (!n) {
+        return NULL;
+    }
+    while (n->rb_right) {
+        n = n->rb_right;
+    }
+    return n;
+}
+
+struct RbNode *rb_next(const struct RbNode *node)
+{
+    struct RbNode *parent;
+
+    if (RB_EMPTY_NODE(node)) {
+        return NULL;
+    }
+
+    /*
+     * If we have a right-hand child, go down and then left as far
+     * as we can.
+     */
+    if (node->rb_right) {
+        node = node->rb_right;
+        while (node->rb_left) {
+            node = node->rb_left;
+        }
+        return (struct RbNode *)node;
+    }
+
+    /*
+     * No right-hand children. Everything down and left is smaller than us,
+     * so any 'next' node must be in the general direction of our parent.
+     * Go up the tree; any time the ancestor is a right-hand child of its
+     * parent, keep going up. First time it's a left-hand child of its
+     * parent, said parent is our 'next' node.
+     */
+    while ((parent = RB_PARENT(node)) && node == parent->rb_right) {
+        node = parent;
+    }
+    return parent;
+}
+
+struct RbNode *rb_prev(const struct RbNode *node)
+{
+    struct RbNode *parent;
+
+    if (RB_EMPTY_NODE(node)) {
+        return NULL;
+    }
+
+    /*
+     * If we have a left-hand child, go down and then right as far
+     * as we can.
+     */
+    if (node->rb_left) {
+        node = node->rb_left;
+        while (node->rb_right) {
+            node = node->rb_right;
+        }
+        return (struct RbNode *)node;
+    }
+
+    /*
+     * No left-hand children. Go up till we find an ancestor which
+     * is a right-hand child of its parent.
+     */
+    while ((parent = RB_PARENT(node)) && node == parent->rb_left) {
+        node = parent;
+    }
+    return parent;
+}
+
+void rb_replace_node(struct RbNode *victim, struct RbNode *new,
+             struct RbRoot *root)
+{
+    struct RbNode *parent = RB_PARENT(victim);
+
+    /* Set the surrounding nodes to point to the replacement */
+    __rb_change_child(victim, new, parent, root);
+    if (victim->rb_left) {
+        rb_set_parent(victim->rb_left, new);
+    }
+    if (victim->rb_right) {
+        rb_set_parent(victim->rb_right, new);
+    }
+    /* Copy the pointers/colour from the victim to the replacement */
+    *new = *victim;
+}
+
+static struct RbNode *rb_left_deepest_node(const struct RbNode *node)
+{
+    for (;;) {
+        if (node->rb_left) {
+            node = node->rb_left;
+        } else if (node->rb_right) {
+            node = node->rb_right;
+        } else {
+            return (struct RbNode *)node;
+        }
+    }
+}
+
+struct RbNode *rb_next_postorder(const struct RbNode *node)
+{
+    const struct RbNode *parent;
+    if (!node) {
+        return NULL;
+    }
+    parent = RB_PARENT(node);
+
+    /* If we're sitting on node, we've already seen our children */
+    if (parent && node == parent->rb_left && parent->rb_right) {
+        /* If we are the parent's left node, go to the parent's right
+         * node then all the way down to the left */
+        return rb_left_deepest_node(parent->rb_right);
+    } else {
+        /* Otherwise we are the parent's right node, and the parent
+         * should be next */
+        return (struct RbNode *)parent;
+    }
+}
+
+struct RbNode *rb_first_postorder(const struct RbRoot *root)
+{
+    if (!root->rb_node) {
+        return NULL;
+    }
+    return rb_left_deepest_node(root->rb_node);
+}
-- 
2.11.0
